#
# Cookbook Name:: yum
# Definition:: yum_repository
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

define :yum_repository do

  name      = params[:name].gsub(/_/, '-')
  repo_name = params[:name]

  Chef::Log.debug "Enabling the yum repository #{name}."

  template "/etc/yum/repos.d/#{name}.repo" do
    source 'repo.erb'
    mode '644'
    owner 'root'
    group 'root'
    variables(
      :repo_name         => name,
      :baseurl           => node[:yum][repo_name.to_sym][:baseurl]           || false,
      :mirrorlist        => node[:yum][repo_name.to_sym][:mirrorlist]        || false,
      :debug_mirrorlist  => node[:yum][repo_name.to_sym][:debug_mirrorlist]  || false,
      :debug_baseurl     => node[:yum][repo_name.to_sym][:debug_baseurl]     || false,
      :source_mirrorlist => node[:yum][repo_name.to_sym][:source_mirrorlist] || false,
      :source_baseurl    => node[:yum][repo_name.to_sym][:source_baseurl]    || false,
      :gpgkey            => node[:yum][repo_name.to_sym][:gpgkey]            || false,
      :gpgcheck          => node[:yum][repo_name.to_sym][:gpgcheck]          || true,
      :enabled           => node[:yum][repo_name.to_sym][:enabled]           || 'false',
      :source_enabled    => node[:yum][repo_name.to_sym][:source_enabled]    || 'false',
      :debug_enabled     => node[:yum][repo_name.to_sym][:debug_enabled]     || 'false'
    )
  end
end

# vi:filetype=ruby:tabstop=2:expandtab
