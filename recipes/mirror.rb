#
# Cookbook Name:: yumrepo
# Recipe:: mirror
#
# Copyright 2011, Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'rsync'
include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

package node[:yum][:mirror][:package]

mdadm "/dev/md0" do
  devices [ '/dev/xvdj', '/dev/xvdk', '/dev/xvdl', '/dev/xvdm' ]
  level 10
  chunk 256
  action [ :create, :assemble ]
end

lvm_physical_volume '/dev/md0'

lvm_volume_group 'raid10' do
  device '/dev/md0'
end

lvm_logical_volume 'sysadm' do
  vg 'sysadm'
  size :free
  action :create
end

# Formats the disks
disks = '/dev/raid10/sysadm'
actions = []
disks.each do |disk| 
  a = execute "make filesystem on #{disk}" do
    command "echo 'formatting #{disk}'; mkfs.ext4 -F #{disk}"
    returns [0,1]
    not_if "tune2fs -l #{disk}"
    action :nothing
  end
  actions << a
end

ruby_block 'Format in parallel' do
  block do
    threads = []
    actions.each do |a|
      threads << Thread.new { |t| a.run_action(:run) }
    end
    threads.each { |t| t.join }
  end
end

directory node[:yum][:mirror][:basedir]

mount node[:yum][:mirror][:basedir] do
  device '/dev/mapper/raid10-sysadm'
  fstype 'ext4'
  action [ :mount, :enable ]
end

dirs = [
  node[:yum][:mirror][:bindir],
  node[:yum][:mirror][:yumdir]
]

dirs.each do |dir|
  directory dir do
    action :create
    recursive true
    owner 'root'
    group 'root'
    mode '755'
  end
end

template "#{node[:yum][:mirror][:bindir]}/yum-repo-sync.rb" do
  source 'yum-repo-sync.rb.erb'
  owner 'root'
  group 'root'
  mode '755'
end

cron 'Sync Yum repos' do
  command "#{node[:yum][:mirror][:bindir]}/yum-repo-sync.rb > /dev/null 2>&1"
  hour node[:yum][:mirror][:cron_hour]
  minute node[:yum][:mirror][:cron_minute]
end

template 'yumrepo.conf' do
  path '/etc/httpd/sites-available/yumrepo.conf'
  source 'yumrepo.conf.erb'
  owner 'root'
  group 'root'
  mode '444'
end

apache_site 'yumrepo.conf'

apache_site '000-default' do
  enable false
end

# vi:filetype=ruby:tabstop=2:expandtab
