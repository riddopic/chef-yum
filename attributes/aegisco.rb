#
# Cookbook Name:: yum
# Attributes:: aegisco
#
# Copyright 2011 Stefano Harding
#
# Licensed under the Apache License Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing software
# distributed under the License is distributed on an "AS IS" BASIS
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if ((node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific') && node[:platform_version].to_i == 5) || node[:platform] == 'fedora'
  Chef::Log.debug "Including attribute yum::aegisco"

  %w[
    aegisco
    aegisco_testing
    aegisco_source
    aegisco_debuginfo
  ].each { |r| default[:yum][:repos] << r }

  if node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific' 
    os = 'rhel'
  elsif node[:platform] == 'fedora'
    os = 'fc'
  end

  default[:yum][:aegisco_rpm]                 = "aegisco-#{os}.rpm"
  default[:yum][:aegisco_source]              = "http://rpm.aegisco.com/aegisco/#{os}/aegisco-#{os}.rpm"

  default[:yum][:aegisco][:baseurl]           = "http://rpm.aegisco.com/aegisco/#{os}/$releasever/$basearch"
  default[:yum][:aegisco][:gpgkey]            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-aegisco'
  default[:yum][:aegisco][:enabled]           = false

  default[:yum][:aegisco_testing][:baseurl]   = "http://testing.aegisco.com/#{os}/$releasever/$basearch"
  default[:yum][:aegisco_testing][:gpgkey]    = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-aegisco'
  default[:yum][:aegisco_testing][:enabled]   = false

  default[:yum][:aegisco_source][:baseurl]    = "http://rpm.aegisco.com/aegisco/#{os}/$releasever/$basearch"
  default[:yum][:aegisco_source][:gpgkey]     = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-aegisco'
  default[:yum][:aegisco_source][:enabled]    = false

  default[:yum][:aegisco_debuginfo][:baseurl] = "http://rpm.aegisco.com/aegisco/#{os}/$releasever/$basearch"
  default[:yum][:aegisco_debuginfo][:gpgkey]  = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-aegisco'
  default[:yum][:aegisco_debuginfo][:enabled] = false
end

# vi:filetype=ruby:tabstop=2:expandtab