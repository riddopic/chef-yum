#
# Cookbook Name:: yum
# Attributes:: ius
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
  Chef::Log.debug "Including attribute yum::ius"

  %w[
    ius
    ius_dev
    ius_testing
  ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i
  arch = node[:kernel][:machine]

  if node[:platform_version].to_i == 6
    ius_release = '1.0-8'
  elsif node[:platform_version].to_i == 5
    ius_release = '1-2'
  elsif node[:platform_version].to_i == 4
    ius_release = '1.0-8'
  end

  default[:yum][:ius_rpm]                         = "ius-release-#{ius_release}.ius.el#{osver}.noarch.rpm"
  default[:yum][:ius_source]                      = "http://dl.iuscommunity.org/pub/ius/stable/Redhat/#{osver}/#{arch}/ius-release-#{ius_release}.ius.el#{osver}.noarch.rpm"

  default[:yum][:ius][:mirrorlist]                = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}&arch=$basearch"
  default[:yum][:ius][:debug_mirrorlist]          = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-debuginfo&arch=$basearch"
  default[:yum][:ius][:source_mirrorlist]         = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-source&arch=$basearch"
  default[:yum][:ius][:gpgkey]                    = 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'
  default[:yum][:ius][:enabled]                   = false
  default[:yum][:ius][:debug_enabled]             = false
  default[:yum][:ius][:source_enabled]            = false

  default[:yum][:ius_dev][:mirrorlist]            = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-dev&arch=$basearch"
  default[:yum][:ius_dev][:debug_mirrorlist]      = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-dev-debuginfo&arch=$basearch"
  default[:yum][:ius_dev][:source_mirrorlist]     = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-dev-source&arch=$basearch"
  default[:yum][:ius_dev][:gpgkey]                = 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'
  default[:yum][:ius_dev][:enabled]               = false
  default[:yum][:ius_dev][:debug_enabled]         = false
  default[:yum][:ius_dev][:source_enabled]        = false

  default[:yum][:ius_testing][:mirrorlist]        = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-testing&arch=$basearch"
  default[:yum][:ius_testing][:debug_mirrorlist]  = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-testing-debuginfo&arch=$basearch"
  default[:yum][:ius_testing][:source_mirrorlist] = "http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el#{osver}-testing-source&arch=$basearch"
  default[:yum][:ius_testing][:gpgkey]            = 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'
  default[:yum][:ius_testing][:enabled]           = false
  default[:yum][:ius_testing][:debug_enabled]     = false
  default[:yum][:ius_testing][:source_enabled]    = false
end

# vi:filetype=ruby:tabstop=2:expandtab