#
# Cookbook Name:: yum
# Attributes:: rbel
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

if node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific'
  Chef::Log.debug "Including attribute yum::rbel"

  %w[ rbel rbel_testing ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i

  default[:yum][:rbel_rpm]                      = "rbel#{osver}"
  default[:yum][:rbel_source]                   = "http://rbel.co/rbel#{osver}"

  default[:yum][:rbel][:baseurl]                = "http://rbel.frameos.org/stable/el#{osver}/$basearch"
  default[:yum][:rbel][:gpgkey]                 = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-RBEL"
  default[:yum][:rbel][:enabled]                = false

  default[:yum][:rbel_testing][:baseurl]        = "http://rbel.frameos.org/testing/el#{osver}/$basearch"
  default[:yum][:rbel_testing][:gpgkey]         = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-RBEL"
  default[:yum][:rbel_testing][:enabled]        = false
end

# vi:filetype=ruby:tabstop=2:expandtab
