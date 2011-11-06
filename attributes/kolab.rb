#
# Cookbook Name:: yum
# Attributes:: kolab
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
  Chef::Log.debug "Including attribute yum::kolab"

  %w[ kolab kolab_development kolab_update kolab_update_testing ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i

  default[:yum][:kolab][:baseurl]                       = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/release/$basearch"
  default[:yum][:kolab][:debug_baseurl]                 = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/release/$basearch/debug"
  default[:yum][:kolab][:source_baseurl]                = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/release/SRPMS"
  default[:yum][:kolab][:gpgkey]                        = 'http://mirror.kolabsys.com/tikanga.asc'
  default[:yum][:kolab][:enabled]                       = false
  default[:yum][:kolab][:source_enabled]                = false
  default[:yum][:kolab][:debug_enabled]                 = false

  default[:yum][:kolab_development][:baseurl]           = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/development/$basearch"
  default[:yum][:kolab_development][:debug_baseurl]     = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/development/$basearch/debug"
  default[:yum][:kolab_development][:source_baseurl]    = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/development/SRPMS"
  default[:yum][:kolab_development][:gpgkey]            = 'http://mirror.kolabsys.com/tikanga.asc'
  default[:yum][:kolab_development][:enabled]           = false
  default[:yum][:kolab_development][:source_enabled]    = false
  default[:yum][:kolab_development][:debug_enabled]     = false

  default[:yum][:kolab_update][:baseurl]                = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates/$basearch"
  default[:yum][:kolab_update][:debug_baseurl]          = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates/$basearch/debug"
  default[:yum][:kolab_update][:source_baseurl]         = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates/SRPMS"
  default[:yum][:kolab_update][:gpgkey]                 = 'http://mirror.kolabsys.com/tikanga.asc'
  default[:yum][:kolab_update][:enabled]                = false
  default[:yum][:kolab_update][:source_enabled]         = false
  default[:yum][:kolab_update][:debug_enabled]          = false

  default[:yum][:kolab_update_testing][:baseurl]        = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates-testing/$basearch"
  default[:yum][:kolab_update_testing][:debug_baseurl]  = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates-testing/$basearch/debug"
  default[:yum][:kolab_update_testing][:source_baseurl] = "http://mirror.kolabsys.com/pub/redhat/kolab-2.3/el#{osver}/updates-testing/SRPMS"
  default[:yum][:kolab_update_testing][:gpgkey]         = 'http://mirror.kolabsys.com/tikanga.asc'
  default[:yum][:kolab_update_testing][:enabled]        = false
  default[:yum][:kolab_update_testing][:source_enabled] = false
  default[:yum][:kolab_update_testing][:debug_enabled]  = false
end

# vi:filetype=ruby:tabstop=2:expandtab
