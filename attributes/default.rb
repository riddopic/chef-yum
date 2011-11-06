#
# Cookbook Name:: yum
# Attributes:: default
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

default[:yum][:repos]                     = []
default[:yum][:packages]                  = %w[ redhat-lsb yum-utils ]
default[:yum][:fastestmirror]             = 'yum-fastestmirror'
default[:yum][:updatesd]                  = 'remove'
default[:yum][:failovermethod]            = 'priority'
default[:yum][:metadata_expire]           = '7d'

default[:yum][:repodir]                   = '/etc/yum/repos.d'
default[:yum][:conf]                      = '/etc/yum.conf'

default[:yum][:mirror][:package]          = 'createrepo'
default[:yum][:mirror][:basedir]          = '/sysadm'
default[:yum][:mirror][:bindir]           = '/sysadm/bin'
default[:yum][:mirror][:yumdir]           = '/sysadm/yum.repos'
default[:yum][:mirror][:cron_hour]        = 1
default[:yum][:mirror][:cron_minute]      = 30

default[:yum][:mirror][:fedora_mirror]    = 'rsync://mirror.rackspace.com/fedora/'
default[:yum][:mirror][:centos_mirror]    = 'rsync://mirror.rackspace.com/centos/'
default[:yum][:mirror][:sl_mirror]        = 'rsync://ftp.scientificlinux.org/scientific/'
default[:yum][:mirror][:dag_mirror]       = 'rsync://rh-mirror.linux.iastate.edu/dag/'
default[:yum][:mirror][:atrpms_mirror]    = 'rsync://dl.atrpms.net/dl.atrpms.net/'
default[:yum][:mirror][:epel_mirror]      = 'rsync://mirror.rackspace.com/epel/'
default[:yum][:mirror][:livna_mirror]     = 'rsync://rpm.livna.org/rlo/fedora/'
default[:yum][:mirror][:rpmfusion_mirror] = 'rsync://download1.rpmfusion.org/rpmfusion/'
default[:yum][:mirror][:ius_mirror]       = 'rsync://dl.iuscommunity.org/ius/'
default[:yum][:mirror][:elff_mirror]      = 'rsync://download.elff.bravenet.com/elff/'
default[:yum][:mirror][:jpackage_mirror]  = 'rsync://rsync.mirrors.dotsrc.org/jpackage/'

default[:yum][:mirror][:sync_fedora]      = true
default[:yum][:mirror][:sync_centos]      = true
default[:yum][:mirror][:sync_sl]          = true
default[:yum][:mirror][:sync_rpmfusion]   = true
default[:yum][:mirror][:sync_atrpms]      = true
default[:yum][:mirror][:sync_livna]       = false
default[:yum][:mirror][:sync_epel]        = true
default[:yum][:mirror][:sync_dag]         = true
default[:yum][:mirror][:sync_ius]         = true
default[:yum][:mirror][:sync_elff]        = true
default[:yum][:mirror][:sync_jpackage]    = true
default[:yum][:mirror][:iso]              = false
default[:yum][:mirror][:arch]             = 'i386 x86_64'

if node[:platform] == 'fedora'
  include_attribute 'yum::fedora'

elsif node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific'
  if node[:platform] == 'centos'
    include_attribute 'yum::centos'

  elsif node[:platform] == 'scientific'
    include_attribute 'yum::scientific'

  elsif node[:platform] == 'redhat'
    include_attribute 'yum::redhat'
  end
  
  include_attribute 'yum::epel'
  include_attribute 'yum::rbel'
  include_attribute 'yum::ius'
  include_attribute 'yum::elff'
  include_attribute 'yum::buildsys'
  include_attribute 'yum::ruby_19'
  include_attribute 'yum::kolab'
  include_attribute 'yum::vmware'

else
  Chef::Log.error "Support for this platform is not available."
end

include_attribute 'yum::custom'
include_attribute 'yum::aegisco'
include_attribute 'yum::rpmfusion'

# vi:filetype=ruby:tabstop=2:expandtab
