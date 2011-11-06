#
# Cookbook Name:: yum
# Recipe:: default
#
# Copyright 2011, Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node[:yum][:packages].each { |pkg| package pkg }

package node[:yum][:fastestmirror]

package 'yum-priorities' do
  package_name value_for_platform(
    'fedora' => { 'default' => 'yum-plugin-priorities' },
    'default' => 'yum-priorities'
  )
  action :install
end

# We don't want to enable automatic updates on production machines.
package 'yum-updatesd' do
  action node[:yum][:updatesd].to_sym
end

# Override and use local repos if you have a local mirror.
server = search(:node, 'recipes:yum\:\:mirror') || []
if server.length > 0
  osver = node[:platform_version].to_i
  arch = node[:kernel][:machine]

  server.each do |srv|
    hosts_entry 'yumrepo' do
      ip srv[:ipaddress]
      aliases [ srv[:hostname], srv[:fqdn], 'mirror' ]
      comment "added by recipe[yum]"
    end

    if srv[:yum][:mirror][:sync_centos] == true
      Chef::Log.debug "Overriding yum::centos"
      node.set[:yum][:release][:baseurl] = 'http://mirror/centos/$releasever/os/$basearch/'
      node.set[:yum][:updates][:baseurl] = 'http://mirror/centos/$releasever/updates/$basearch/'
      node.set[:yum][:contrib][:baseurl] = 'http://mirror/centos/$releasever/contrib/$basearch/'
      node.set[:yum][:addons][:baseurl]  = 'http://mirror/centos/$releasever/addons/$basearch/'
      node.set[:yum][:extra][:baseurl]   = 'http://mirror/centos/$releasever/extras/$basearch/'
      node.set[:yum][:plus][:baseurl]    = 'http://mirror/centos/$releasever/centosplus/$basearch/'
    end

    if srv[:yum][:mirror][:sync_elff] == true
      Chef::Log.debug "Overriding yum::elff"
      node.set[:yum][:elff_source]                   = "http://mirror/elff/5/#{arch}/elff-release-5-3.noarch.rpm"
      node.set[:yum][:elff][:baseurl]                = 'http://mirror/elff/5/$basearch/'
      node.set[:yum][:elff][:debug_baseurl]          = 'http://mirror/elff/5/$basearch/debug/'
      node.set[:yum][:elff][:source_baseurl]         = 'http://mirror/elff/5/SRPMS/'
      node.set[:yum][:elff_testing][:baseurl]        = 'http://mirror/elff/testing/5/$basearch/'
      node.set[:yum][:elff_testing][:debug_baseurl]  = 'http://mirror/elff/testing/5/$basearch/debug/'
      node.set[:yum][:elff_testing][:source_baseurl] = 'http://mirror/elff/testing/5/SRPMS/'
    end

    if srv[:yum][:mirror][:sync_epel] == true
      Chef::Log.debug "Overriding yum::epel"
      if node[:platform_version].to_i == 6
        epel_release = '6-5'
      elsif node[:platform_version].to_i == 5
        epel_release = '5-4'
      elsif node[:platform_version].to_i == 4
        epel_release = '4-10'
      end
      node.set[:yum][:epel_source]                   = "http://mirror/epel/#{osver}/#{arch}/epel-release-#{epel_release}.noarch.rpm"
      node.set[:yum][:epel][:baseurl]                = "http://mirror/epel/#{osver}/$basearch/"
      node.set[:yum][:epel][:debug_baseurl]          = "http://mirror/epel/#{osver}/$basearch/"
      node.set[:yum][:epel][:source_baseurl]         = "http://mirror/epel/#{osver}/SRPMS/"
      node.set[:yum][:epel_testing][:baseurl]        = "http://mirror/epel/testing/#{osver}/$basearch/"
      node.set[:yum][:epel_testing][:debug_baseurl]  = "http://mirror/epel/testing/#{osver}/$basearch/debug/"
      node.set[:yum][:epel_testing][:source_baseurl] = "http://mirror/epel/testing/#{osver}/SRPMS/"
    end

    if srv[:yum][:mirror][:sync_fedora] == true
      Chef::Log.debug "Overriding yum::fedora"
      node.set[:yum][:release][:baseurl]                = 'http://mirror/fedora/releases/$releasever/Everything/$basearch/os/'
      node.set[:yum][:release][:debug_baseurl]          = 'http://mirror/fedora/releases/$releasever/Everything/$basearch/debug/'
      node.set[:yum][:release][:source_baseurl]         = 'http://mirror/fedora/releases/$releasever/Everything/source/SRPMS/'

      node.set[:yum][:updates][:baseurl]                = 'http://mirror/fedora/updates/$releasever/$basearch/'
      node.set[:yum][:updates][:debug_baseurl]          = 'http://mirror/fedora/updates/$releasever/$basearch/debug/'
      node.set[:yum][:updates][:source_baseurl]         = 'http://mirror/fedora/updates/$releasever/SRPMS/'

      node.set[:yum][:updates_testing][:baseurl]        = 'http://mirror/fedora/updates/testing/$releasever/$basearch/'
      node.set[:yum][:updates_testing][:debug_baseurl]  = 'http://mirror/fedora/updates/testing/$releasever/$basearch/debug/'
      node.set[:yum][:updates_testing][:source_baseurl] = 'http://mirror/fedora/updates/testing/$releasever/SRPMS/'
    end
    
    if srv[:yum][:mirror][:sync_ius] == true
      Chef::Log.debug "Overriding yum::ius"
      if node[:platform_version].to_i == 6
        ius_release = '1.0-8'
      elsif node[:platform_version].to_i == 5
        ius_release = '1-2'
      elsif node[:platform_version].to_i == 4
        ius_release = '1.0-8'
      end
      node.set[:yum][:ius_source]                   = "http://mirror/ius/stable/Redhat/#{osver}/#{arch}/ius-release-#{ius_release}.ius.el#{osver}.noarch.rpm"
      node.set[:yum][:ius][:baseurl]                = "http://mirror/ius/stable/Redhat/#{osver}/$basearch"
      node.set[:yum][:ius][:debug_baseurl]          = "http://mirror/ius/stable/Redhat/#{osver}/$basearch/debuginfo"
      node.set[:yum][:ius][:source_baseurl]         = "http://mirror/ius/stable/Redhat/#{osver}/SRPMS"
      node.set[:yum][:ius_dev][:baseurl]            = "http://mirror/ius/development/Redhat/#{osver}/$basearch"
      node.set[:yum][:ius_dev][:debug_baseurl]      = "http://mirror/ius/development/Redhat/#{osver}/$basearch/debuginfo"
      node.set[:yum][:ius_dev][:source_baseurl]     = "http://mirror/ius/development/Redhat/#{osver}/SRPMS"
      node.set[:yum][:ius_testing][:baseurl]        = "http://mirror/ius/testing/Redhat/#{osver}/$basearch"
      node.set[:yum][:ius_testing][:debug_baseurl]  = "http://mirror/ius/testing/Redhat/#{osver}/$basearch/debuginfo"
      node.set[:yum][:ius_testing][:source_baseurl] = "http://mirror/ius/testing/Redhat/#{osver}/SRPMS"
      if default[:yum][:ius][:enabled] == true
        package 'yum-plugin-replace'
      end
    end
    
    if srv[:yum][:mirror][:sync_rpmfusion] == true
      Chef::Log.debug "Overriding yum::rpmfusion"
      if node[:platform] == 'centos' || node[:platform] == 'redhat' || node[:platform] == 'scientific'
        os = 'el'
        if node[:platform_version].to_i == 6
          release = '6-0.1'
        elsif node[:platform_version].to_i == 5
          release = '5-0.1'
        end
        node.set[:yum][:rpmfusion_free_source]    = "http://mirror/rpmfusion/free/el/updates/testing/#{osver}/#{arch}/rpmfusion-free-release-#{release}.noarch.rpm"
        node.set[:yum][:rpmfusion_nonfree_source] = "http://mirror/rpmfusion/nonfree/el/updates/testing/#{osver}/#{arch}/rpmfusion-nonfree-release-#{release}.noarch.rpm"
      elsif node[:platform] == 'fedora'
        os = 'fedora'
        node.set[:yum][:rpmfusion_free_source]    = "http://mirror/rpmfusion/free/fedora/updates/#{osver}/#{arch}/rpmfusion-free-release-#{osver}-1.noarch.rpm"
        node.set[:yum][:rpmfusion_nonfree_source] = "http://mirror/rpmfusion/nonfree/fedora/updates/#{osver}/#{arch}/rpmfusion-nonfree-release-#{osver}-1.noarch.rpm"
        
        node.set[:yum][:rpmfusion_free_rawhide][:baseurl]                 = 'http://mirror/rpmfusion/free/fedora/development/$basearch/os/'
        node.set[:yum][:rpmfusion_free_rawhide][:debug_baseurl]           = 'http://mirror/rpmfusion/free/fedora/development/$basearch/os/debug/'
        node.set[:yum][:rpmfusion_free_rawhide][:source_baseurl]          = 'http://mirror/rpmfusion/free/fedora/development/$basearch/source/SRPMS/'
        node.set[:yum][:rpmfusion_nonfree_rawhide][:baseurl]              = 'http://mirror/rpmfusion/nonfree/fedora/development/$basearch/os/'
        node.set[:yum][:rpmfusion_nonfree_rawhide][:debug_baseurl]        = 'http://mirror/rpmfusion/nonfree/fedora/development/$basearch/os/debug/'
        node.set[:yum][:rpmfusion_nonfree_rawhide][:source_baseurl]       = 'http://mirror/rpmfusion/nonfree/fedora/development/$basearch/source/SRPMS/'
      end
    
      node.set[:yum][:rpmfusion_free][:baseurl]                           = "http://mirror/rpmfusion/free/#{os}/releases/#{osver}/Everything/$basearch/os/"
      node.set[:yum][:rpmfusion_free][:debug_baseurl]                     = "http://mirror/rpmfusion/free/#{os}/releases/#{osver}/Everything/$basearch/os/debug/"
      node.set[:yum][:rpmfusion_free][:source_baseurl]                    = "http://mirror/rpmfusion/free/#{os}/releases/#{osver}/Everything/source/SRPMS/"
      node.set[:yum][:rpmfusion_free_updates][:baseurl]                   = "http://mirror/rpmfusion/free/#{os}/updates/#{osver}/$basearch/"
      node.set[:yum][:rpmfusion_free_updates][:debug_baseurl]             = "http://mirror/rpmfusion/free/#{os}/updates/#{osver}/$basearch/debug/"
      node.set[:yum][:rpmfusion_free_updates][:source_baseurl]            = "http://mirror/rpmfusion/free/#{os}/updates/#{osver}/SRPMS/"
      node.set[:yum][:rpmfusion_free_updates_testing][:baseurl]           = "http://mirror/rpmfusion/free/#{os}/updates/testing/#{osver}/$basearch/"
      node.set[:yum][:rpmfusion_free_updates_testing][:debug_baseurl]     = "http://mirror/rpmfusion/free/#{os}/updates/testing/#{osver}/$basearch/debug/"
      node.set[:yum][:rpmfusion_free_updates_testing][:source_baseurl]    = "http://mirror/rpmfusion/free/#{os}/updates/testing/#{osver}/SRPMS/"
      node.set[:yum][:rpmfusion_nonfree][:baseurl]                        = "http://mirror/rpmfusion/nonfree/#{os}/releases/#{osver}/Everything/$basearch/os/"
      node.set[:yum][:rpmfusion_nonfree][:debug_baseurl]                  = "http://mirror/rpmfusion/nonfree/#{os}/releases/#{osver}/Everything/$basearch/os/debug/"
      node.set[:yum][:rpmfusion_nonfree][:source_baseurl]                 = "http://mirror/rpmfusion/nonfree/#{os}/releases/#{osver}/Everything/source/SRPMS/"
      node.set[:yum][:rpmfusion_nonfree_updates][:baseurl]                = "http://mirror/rpmfusion/nonfree/#{os}/updates/#{osver}/$basearch/"
      node.set[:yum][:rpmfusion_nonfree_updates][:debug_baseurl]          = "http://mirror/rpmfusion/nonfree/#{os}/updates/#{osver}/$basearch/debug/"
      node.set[:yum][:rpmfusion_nonfree_updates][:source_baseurl]         = "http://mirror/rpmfusion/nonfree/#{os}/updates/#{osver}/SRPMS/"
      node.set[:yum][:rpmfusion_nonfree_updates_testing][:baseurl]        = "http://mirror/rpmfusion/nonfree/#{os}/updates/testing/#{osver}/$basearch/"
      node.set[:yum][:rpmfusion_nonfree_updates_testing][:debug_baseurl]  = "http://mirror/rpmfusion/nonfree/#{os}/updates/testing/#{osver}/$basearch/debug/"
      node.set[:yum][:rpmfusion_nonfree_updates_testing][:source_baseurl] = "http://mirror/rpmfusion/nonfree/#{os}/updates/testing/#{osver}/SRPMS/"
    end
  
    if srv[:yum][:mirror][:sync_sl] == true
      Chef::Log.debug "Overriding yum::scientific"
      node.set[:yum][:sl][:baseurl]             = 'http://mirror/scientific/$releasever/$basearch/os/'
      node.set[:yum][:security][:baseurl]       = 'http://mirror/scientific/$releasever/$basearch/updates/security/'
      node.set[:yum][:source][:baseurl]         = 'http://mirror/scientific/$releasever/SRPMS/'
      node.set[:yum][:fastbugs][:baseurl]       = 'http://mirror/scientific/$releasever/$basearch/updates/fastbugs/'
      node.set[:yum][:debuginfo][:baseurl]      = 'http://mirror/scientific/$releasever/archive/debuginfo/'
      node.set[:yum][:testing][:baseurl]        = 'http://mirror/scientific/$releasever/testing/$basearch/'
      node.set[:yum][:testing_source][:baseurl] = 'http://mirror/scientific/$releasever/testing/SRPMS/'
    end
  end

  # TODO - this is a little too hard coded for your own good no?
  node.set[:yum][:custom][:baseurl] = "http://yumrepo/custom/el#{osver}/$basearch"
  node.set[:yum][:custom][:enabled] = true

else
  Chef::Log.info("No local yum mirror server found.")
end

# The EPEL, RPMFusion and ELFF repository RPMs are being installed to get the
# GPG keys. The bad part of remote file at the moment is that if the remote is
# down chef will fail. We should use a local mirror.
if platform?('centos', 'scientific', 'redhat')
  if node[:platform_version].to_i == 5
    remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:elff_rpm]}" do
      source node[:yum][:elff_source]
      not_if "rpm -qa | grep -qx '#{node[:yum][:elff_rpm].gsub('.rpm', '')}'"
    end

    rpm_package node[:yum][:elff_rpm] do
      source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:elff_rpm]}"
    end
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:epel_rpm]}" do
    source node[:yum][:epel_source]
    not_if "rpm -qa | grep -qx '#{node[:yum][:epel_rpm].gsub('.rpm', '')}'"
  end

  rpm_package node[:yum][:epel_rpm] do
    source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:epel_rpm]}"
    not_if "rpm -qa | grep -qx '#{node[:yum][:epel_rpm].gsub('.rpm', '')}'"
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rbel_rpm]}" do
    source node[:yum][:rbel_source]
    not_if "rpm -qa | grep -qx '#{node[:yum][:rbel_rpm].gsub('.rpm', '')}'"
  end

  rpm_package node[:yum][:rbel_rpm] do
    source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rbel_rpm]}"
    not_if "rpm -qa | grep -qx '#{node[:yum][:rbel_rpm].gsub('.rpm', '')}'"
  end
  
  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:ius_rpm]}" do
    source node[:yum][:ius_source]
    not_if "rpm -qa | grep -qx '#{node[:yum][:ius_rpm].gsub('.rpm', '')}'"
  end

  rpm_package node[:yum][:ius_rpm] do
    source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:ius_rpm]}"
    not_if "rpm -qa | grep -qx '#{node[:yum][:ius_rpm].gsub('.rpm', '')}'"
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rpmfusion_free_rpm]}" do
  source node[:yum][:rpmfusion_free_source]
  not_if "rpm -qa | grep -qx '#{node[:yum][:rpmfusion_free_rpm].gsub('.rpm', '')}'"
end

rpm_package node[:yum][:rpmfusion_free_rpm] do
  source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rpmfusion_free_rpm]}"
  not_if "rpm -qa | grep -qx '#{node[:yum][:rpmfusion_free_rpm].gsub('.rpm', '')}'"
  options '--nodeps'
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rpmfusion_nonfree_rpm]}" do
  source node[:yum][:rpmfusion_nonfree_source]
  not_if "rpm -qa | grep -qx '#{node[:yum][:rpmfusion_nonfree_rpm].gsub('.rpm', '')}'"
end

rpm_package node[:yum][:rpmfusion_nonfree_rpm] do
  source "#{Chef::Config[:file_cache_path]}/#{node[:yum][:rpmfusion_nonfree_rpm]}"
  not_if "rpm -qa | grep -qx '#{node[:yum][:rpmfusion_nonfree_rpm].gsub('.rpm', '')}'"
  options '--nodeps'
end

# This space is managed by RPM. We don't want to use it to make it clear we
# ship our own repos.
directory '/etc/yum.repos.d' do
  action :delete
  recursive true
end

directory node[:yum][:repodir] do
  action :create
  owner 'root'
  group 'root'
  mode '755'
end

template node[:yum][:conf] do
  source 'yum.conf.erb'
  mode '444'
  owner 'root'
  group 'root'
end

# Enable the yum repos
node[:yum][:repos].uniq.each { |r| yum_repository r }

# vi:filetype=ruby:tabstop=2:expandtab
