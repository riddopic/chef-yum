#
# Cookbook Name:: yum
# Attributes:: fedora
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

default[:yum][:fastestmirror] = 'yum-plugin-fastestmirror'

if node[:platform] == 'fedora'
  Chef::Log.debug "Including attribute yum::fedora"

  %w[ release updates updates_testing ].each { |r| default[:yum][:repos] << r }

  default[:yum][:release][:mirrorlist]                 = 'https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch'
  default[:yum][:release][:debug_mirrorlist]           = 'https://mirrors.fedoraproject.org/metalink?repo=fedora-debug-$releasever&arch=$basearch'
  default[:yum][:release][:source_mirrorlist]          = 'https://mirrors.fedoraproject.org/metalink?repo=fedora-source-$releasever&arch=$basearch'
  default[:yum][:release][:gpgkey]                     = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch'
  default[:yum][:release][:enabled]                    = true
  default[:yum][:release][:source_enabled]             = false
  default[:yum][:release][:debug_enabled]              = false

  default[:yum][:updates][:mirrorlist]                 = 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch'
  default[:yum][:updates][:debug_mirrorlist]           = 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-debug-f$releasever&arch=$basearch'
  default[:yum][:updates][:source_mirrorlist]          = 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-source-f$releasever&arch=$basearch'
  default[:yum][:updates][:gpgkey]                     = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch'
  default[:yum][:updates][:enabled]                    = true
  default[:yum][:updates][:source_enabled]             = false
  default[:yum][:updates][:debug_enabled]              = false

  default[:yum][:updates_testing][:mirrorlist]        = 'https://mirrors.fedoraproject.org/metalink?repo=updates-testing-f$releasever&arch=$basearch'
  default[:yum][:updates_testing][:debug_mirrorlist]  = 'https://mirrors.fedoraproject.org/metalink?repo=updates-testing-debug-f$releasever&arch=$basearch'
  default[:yum][:updates_testing][:source_mirrorlist] = 'https://mirrors.fedoraproject.org/metalink?repo=updates-testing-source-f$releasever&arch=$basearch'
  default[:yum][:updates_testing][:gpgkey]            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch'
  default[:yum][:updates_testing][:enabled]           = false
  default[:yum][:updates_testing][:source_enabled]    = false
  default[:yum][:updates_testing][:debug_enabled]     = false
end

# vi:filetype=ruby:tabstop=2:expandtab
