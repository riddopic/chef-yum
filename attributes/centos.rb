#
# Cookbook Name:: yum
# Attributes:: centos
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

if node[:platform] == 'centos'
  Chef::Log.debug "Including attribute yum::centos"

  %w[ addons plus extras contrib ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i

  default[:yum][:release][:mirrorlist] = "http://mirrorlist.centos.org/?release=#{osver}&arch=$basearch&repo=os"
  default[:yum][:release][:gpgkey]     = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
  default[:yum][:release][:enabled]    = true

  default[:yum][:updates][:mirrorlist] = "http://mirrorlist.centos.org/?release=#{osver}&arch=$basearch&repo=updates"
  default[:yum][:updates][:gpgkey]     = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
  default[:yum][:updates][:enabled]    = true

  default[:yum][:contrib][:mirrorlist] = "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib"
  default[:yum][:contrib][:gpgkey]     = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
  default[:yum][:contrib][:enabled]    = false

  default[:yum][:addons][:mirrorlist]  = "http://mirrorlist.centos.org/?release=#{osver}&arch=$basearch&repo=addons"
  default[:yum][:addons][:gpgkey]      = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
  default[:yum][:addons][:enabled]     = false

  default[:yum][:extra][:mirrorlist]   = "http://mirrorlist.centos.org/?release=#{osver}&arch=$basearch&repo=extras"
  default[:yum][:extra][:gpgkey]       = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
  default[:yum][:extra][:enabled]      = false

  default[:yum][:plus][:mirrorlist]    = "http://mirrorlist.centos.org/?release=#{osver}&arch=$basearch&repo=centosplus"
  default[:yum][:plus][:gpgkey]        = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{osver}"
end

# vi:filetype=ruby:tabstop=2:expandtab
