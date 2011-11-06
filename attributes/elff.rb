#
# Cookbook Name:: yum
# Attributes:: elff
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

if (node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific') && node[:platform_version].to_i == 5
  Chef::Log.debug "Including attribute yum::elff"
  arch = node[:kernel][:machine]

  %w[ elff elff_testing ].each { |r| default[:yum][:repos] << r }

  default[:yum][:elff_version]                   = '5-3'
  default[:yum][:elff_rpm]                       = 'elff-release-5-3.noarch.rpm'
  default[:yum][:elff_source]                    = "http://download.elff.bravenet.com/5/#{arch}/elff-release-5-3.noarch.rpm"

  default[:yum][:elff][:baseurl]                 = 'http://download.elff.bravenet.com/5/$basearch'
  default[:yum][:elff][:debug_baseurl]           = 'http://download.elff.bravenet.com/5/$basearch/debug'
  default[:yum][:elff][:source_baseurl]          = 'http://download.elff.bravenet.com/5/SRPMS'
  default[:yum][:elff][:gpgkey]                  = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF'
  default[:yum][:elff][:enabled]                 = true
  default[:yum][:elff][:source_enabled]          = false
  default[:yum][:elff][:debug_enabled]           = false

  default[:yum][:elff_testing][:baseurl]         = 'http://download.elff.bravenet.com/testing/5/$basearch'
  default[:yum][:elff_testing][:debug_baseurl]   = 'http://download.elff.bravenet.com/testing/5/$basearch/debug'
  default[:yum][:elff_testing][:source_baseurl]  = 'http://download.elff.bravenet.com/testing/5/SRPMS'
  default[:yum][:elff_testing][:gpgkey]          = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF'
  default[:yum][:elff_testing][:enabled]         = false
  default[:yum][:elff_testing][:source_enabled]  = false
  default[:yum][:elff_testing][:debug_enabled]   = false
end

# vi:filetype=ruby:tabstop=2:expandtab
