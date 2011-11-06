#
# Cookbook Name:: yum
# Attributes:: buildsys
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
  Chef::Log.debug "Including attribute yum::buildsys"

  %w[ buildsys ].each { |r| default[:yum][:repos] << r }

  default[:yum][:buildsys][:baseurl]        = "http://mirror.nl.ergo-project.org/repositories/custom-el5-buildsys/$basearch/"
  default[:yum][:buildsys][:debug_baseurl]  = "http://mirror.nl.ergo-project.org/repositories/custom-el5-buildsys/$basearch/debug/"
  default[:yum][:buildsys][:source_baseurl] = "http://mirror.nl.ergo-project.org/repositories/custom-el5-buildsys/SRPMS/"
  default[:yum][:buildsys][:enabled]        = false
  default[:yum][:buildsys][:source_enabled] = false
  default[:yum][:buildsys][:debug_enabled]  = false
end

# vi:filetype=ruby:tabstop=2:expandtab
