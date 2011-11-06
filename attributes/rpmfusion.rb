#
# Cookbook Name:: yum
# Attributes:: rpmfusion
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

if node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific' || node[:platform] == 'fedora'
  Chef::Log.debug "Including attribute yum::rpmfusion"

  %w[
    rpmfusion_free_updates
    rpmfusion_free_updates_testing
    rpmfusion_nonfree_updates
    rpmfusion_nonfree_updates_testing
  ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i
  arch = node[:kernel][:machine]

  if node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific'
    os = 'el'
    gpgkey = 'el'

    if node[:platform_version].to_i == 6
      release = '6-0.1'
    elsif node[:platform_version].to_i == 5
      release = '5-0.1'
    end

    default[:yum][:rpmfusion_free_rpm]        = "rpmfusion-free-release-#{release}.noarch.rpm"
    default[:yum][:rpmfusion_free_source]     = "http://download1.rpmfusion.org/free/el/updates/testing/#{osver}/#{arch}/rpmfusion-free-release-#{release}.noarch.rpm"

    default[:yum][:rpmfusion_nonfree_rpm]     = "rpmfusion-nonfree-release-#{release}.noarch.rpm"
    default[:yum][:rpmfusion_nonfree_source]  = "http://download1.rpmfusion.org/nonfree/el/updates/testing/#{osver}/#{arch}/rpmfusion-nonfree-release-#{release}.noarch.rpm"
    
    default[:yum][:rpmfusion_free][:mirrorlist]                           = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free][:debug_mirrorlist]                     = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-debug-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free][:source_mirrorlist]                    = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free][:gpgkey]                               = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el'
    default[:yum][:rpmfusion_free][:enabled]                              = true
    default[:yum][:rpmfusion_free][:source_enabled]                       = false
    default[:yum][:rpmfusion_free][:debug_enabled]                        = false

    default[:yum][:rpmfusion_free_updates][:mirrorlist]                   = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates][:debug_mirrorlist]             = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-debug-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates][:source_mirrorlist]            = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates][:gpgkey]                       = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el'
    default[:yum][:rpmfusion_free_updates][:enabled]                      = true
    default[:yum][:rpmfusion_free_updates][:source_enabled]               = false
    default[:yum][:rpmfusion_free_updates][:debug_enabled]                = false

    default[:yum][:rpmfusion_free_updates_testing][:mirrorlist]           = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates_testing][:debug_mirrorlist]     = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-debug-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates_testing][:source_mirrorlist]    = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_free_updates_testing][:gpgkey]               = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el'
    default[:yum][:rpmfusion_free_updates_testing][:enabled]              = false
    default[:yum][:rpmfusion_free_updates_testing][:source_enabled]       = false
    default[:yum][:rpmfusion_free_updates_testing][:debug_enabled]        = false

    default[:yum][:rpmfusion_nonfree][:mirrorlist]                        = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree][:debug_mirrorlist]                  = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-debug-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree][:source_mirrorlist]                 = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree][:gpgkey]                            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el'
    default[:yum][:rpmfusion_nonfree][:enabled]                           = true
    default[:yum][:rpmfusion_nonfree][:source_enabled]                    = false
    default[:yum][:rpmfusion_nonfree][:debug_enabled]                     = false

    default[:yum][:rpmfusion_nonfree_updates][:mirrorlist]                = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates][:debug_mirrorlist]          = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates][:source_mirrorlist]         = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates][:gpgkey]                    = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el'
    default[:yum][:rpmfusion_nonfree_updates][:enabled]                   = true
    default[:yum][:rpmfusion_nonfree_updates][:source_enabled]            = false
    default[:yum][:rpmfusion_nonfree_updates][:debug_enabled]             = false

    default[:yum][:rpmfusion_nonfree_updates_testing][:mirrorlist]        = "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-testing-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates_testing][:debug_mirrorlist]  = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-testing-debug-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates_testing][:source_mirrorlist] = "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-testing-source-#{osver}&arch=$basearch"
    default[:yum][:rpmfusion_nonfree_updates_testing][:gpgkey]            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el'
    default[:yum][:rpmfusion_nonfree_updates_testing][:enabled]           = false
    default[:yum][:rpmfusion_nonfree_updates_testing][:source_enabled]    = false
    default[:yum][:rpmfusion_nonfree_updates_testing][:debug_enabled]     = false

  elsif node[:platform] == 'fedora'
    os = 'fedora'
    gpgkey = 'fedora-$releasever-$basearch'

    %w[
      rpmfusion_free
      rpmfusion_free_rawhide
      rpmfusion_nonfree
      rpmfusion_nonfree_rawhide
    ].each { |r| default[:yum][:repos] << r }

    default[:yum][:rpmfusion_free_rpm]        = "rpmfusion-free-release-#{osver}-1.noarch.rpm"
    default[:yum][:rpmfusion_free_source]     = "http://download1.rpmfusion.org/free/fedora/updates/#{osver}/#{arch}/rpmfusion-free-release-#{osver}-1.noarch.rpm"

    default[:yum][:rpmfusion_nonfree_rpm]     = "rpmfusion-nonfree-release-#{osver}-1.noarch.rpm"
    default[:yum][:rpmfusion_nonfree_source]  = "http://download1.rpmfusion.org/nonfree/fedora/updates/#{osver}/#{arch}/rpmfusion-nonfree-release-#{osver}-1.noarch.rpm"
    
    default[:yum][:rpmfusion_free][:mirrorlist]                        = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free][:debug_mirrorlist]                  = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free][:source_mirrorlist]                 = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free][:gpgkey]                            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_free][:enabled]                           = true
    default[:yum][:rpmfusion_free][:source_enabled]                    = false
    default[:yum][:rpmfusion_free][:debug_enabled]                     = false

    default[:yum][:rpmfusion_free_updates][:mirrorlist]                = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates][:debug_mirrorlist]          = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates][:source_mirrorlist]         = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates][:gpgkey]                    = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_free_updates][:enabled]                   = true
    default[:yum][:rpmfusion_free_updates][:source_enabled]            = false
    default[:yum][:rpmfusion_free_updates][:debug_enabled]             = false

    default[:yum][:rpmfusion_free_updates_testing][:mirrorlist]        = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-testing-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates_testing][:debug_mirrorlist]  = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-testing-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates_testing][:source_mirrorlist] = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-testing-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_free_updates_testing][:gpgkey]            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_free_updates_testing][:enabled]           = false
    default[:yum][:rpmfusion_free_updates_testing][:source_enabled]    = false
    default[:yum][:rpmfusion_free_updates_testing][:debug_enabled]     = false

    default[:yum][:rpmfusion_free_rawhide][:mirrorlist]                = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide&arch=$basearch'
    default[:yum][:rpmfusion_free_rawhide][:debug_mirrorlist]          = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide-debug&arch=$basearch'
    default[:yum][:rpmfusion_free_rawhide][:source_mirrorlist]         = 'http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide-source&arch=$basearch'
    default[:yum][:rpmfusion_free_rawhide][:gpgkey]                    = %w[ file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-latest-$basearch
                                                                             file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-rawhide-$basearch ]
    default[:yum][:rpmfusion_free_rawhide][:enabled]                   = false
    default[:yum][:rpmfusion_free_rawhide][:source_enabled]            = false
    default[:yum][:rpmfusion_free_rawhide][:debug_enabled]             = false

    default[:yum][:rpmfusion_nonfree][:mirrorlist]                     = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree][:debug_mirrorlist]               = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree][:source_mirrorlist]              = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree][:gpgkey]                         = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_nonfree][:enabled]                        = true
    default[:yum][:rpmfusion_nonfree][:source_enabled]                 = false
    default[:yum][:rpmfusion_nonfree][:debug_enabled]                  = false

    default[:yum][:rpmfusion_nonfree_updates][:mirrorlist]             = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates][:debug_mirrorlist]       = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates][:source_mirrorlist]      = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates][:gpgkey]                 = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_nonfree_updates][:enabled]                = true
    default[:yum][:rpmfusion_nonfree_updates][:source_enabled]         = false
    default[:yum][:rpmfusion_nonfree_updates][:debug_enabled]          = false

    default[:yum][:rpmfusion_nonfree_updates_testing][:mirrorlist]        = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-testing-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates_testing][:debug_mirrorlist]  = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-testing-debug-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates_testing][:source_mirrorlist] = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-testing-source-$releasever&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_updates_testing][:gpgkey]            = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$releasever-$basearch'
    default[:yum][:rpmfusion_nonfree_updates_testing][:enabled]           = false
    default[:yum][:rpmfusion_nonfree_updates_testing][:source_enabled]    = false
    default[:yum][:rpmfusion_nonfree_updates_testing][:debug_enabled]     = false

    default[:yum][:rpmfusion_nonfree_rawhide][:mirrorlist]                = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_rawhide][:debug_mirrorlist]          = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide-debug&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_rawhide][:source_mirrorlist]         = 'http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide-source&arch=$basearch'
    default[:yum][:rpmfusion_nonfree_rawhide][:gpgkey]                    = %w[ file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-latest-$basearch
                                                                                file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-rawhide-$basearch ]
    default[:yum][:rpmfusion_nonfree_rawhide][:enabled]                   = false
    default[:yum][:rpmfusion_nonfree_rawhide][:source_enabled]            = false
    default[:yum][:rpmfusion_nonfree_rawhide][:debug_enabled]             = false
  end
end

# vi:filetype=ruby:tabstop=2:expandtab