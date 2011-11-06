#
# Cookbook Name:: yum
# Attributes:: epel
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
  Chef::Log.debug "Including attribute yum::epel"

  %w[ epel epel_testing ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i
  arch = node[:kernel][:machine]

  if node[:platform_version].to_i == 6
    epel_release = '6-5'
  elsif node[:platform_version].to_i == 5
    epel_release = '5-4'
  elsif node[:platform_version].to_i == 4
    epel_release = '4-10'
  end

  default[:yum][:epel_rpm]                      = "epel-release-#{epel_release}.noarch.rpm"
  default[:yum][:epel_source]                   = "http://download.fedoraproject.org/pub/epel/#{osver}/#{arch}/epel-release-#{epel_release}.noarch.rpm"

  default[:yum][:epel][:mirrorlist]             = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{osver}&arch=$basearch"
  default[:yum][:epel][:baseurl]                = "http://download.fedoraproject.org/pub/epel/#{osver}/$basearch"
  default[:yum][:epel][:debug_mirrorlist]       = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{osver}&arch=$basearch"
  default[:yum][:epel][:debug_baseurl]          = "http://download.fedoraproject.org/pub/epel/#{osver}/$basearch"
  default[:yum][:epel][:source_mirrorlist]      = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-#{osver}&arch=$basearch"
  default[:yum][:epel][:source_baseurl]         = "http://download.fedoraproject.org/pub/epel/#{osver}/SRPMS"
  default[:yum][:epel][:gpgkey]                 = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-#{osver}"
  default[:yum][:epel][:enabled]                = true
  default[:yum][:epel][:source_enabled]         = false
  default[:yum][:epel][:debug_enabled]          = false

  default[:yum][:epel_testing][:baseurl]        = "http://download.fedoraproject.org/pub/epel/testing/#{osver}/$basearch"
  default[:yum][:epel_testing][:debug_baseurl]  = "http://download.fedoraproject.org/pub/epel/testing/#{osver}/$basearch/debug"
  default[:yum][:epel_testing][:source_baseurl] = "http://download.fedoraproject.org/pub/epel/testing/#{osver}/SRPMS"
  default[:yum][:epel_testing][:gpgkey]         = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-#{osver}"
  default[:yum][:epel_testing][:enabled]        = false
  default[:yum][:epel_testing][:source_enabled] = false
  default[:yum][:epel_testing][:debug_enabled]  = false
end

# vi:filetype=ruby:tabstop=2:expandtab
