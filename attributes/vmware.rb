#
# Cookbook Name:: yum
# Attributes:: vmware
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
  Chef::Log.debug "Including attribute yum::vmware"

  %w[ vmware ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i

  default[:yum][:vmware][:baseurl]        = "http://packages.vmware.com/tools/esx/latest/rhel#{osver}/$basearch/"
  default[:yum][:vmware][:source_baseurl] = "http://packages.vmware.com/tools/esx/latest/rhel#{osver}/SRPMS/"
  default[:yum][:vmware][:gpgkey]         = "http://packages.vmware.com/tools/VMWARE-PACKAGING-GPG-KEY.pub"
  default[:yum][:vmware][:enabled]        = false
  default[:yum][:vmware][:source_enabled] = false
end

# vi:filetype=ruby:tabstop=2:expandtab
