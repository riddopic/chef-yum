#
# Cookbook Name:: yum
# Attributes:: ruby_19
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
  Chef::Log.debug "Including attribute yum::ruby_19"

  %w[ ruby_19 ].each { |r| default[:yum][:repos] << r }

  osver = node[:platform_version].to_i

  default[:yum][:ruby_19][:baseurl]        = "http://mirror.nl.ergo-project.org/repositories/feature-el#{osver}-ruby-1.9.1/$basearch/"
  default[:yum][:ruby_19][:debug_baseurl]  = "http://mirror.nl.ergo-project.org/repositories/feature-el#{osver}-ruby-1.9.1/$basearch/debug/"
  default[:yum][:ruby_19][:source_baseurl] = "http://mirror.nl.ergo-project.org/repositories/feature-el#{osver}-ruby-1.9.1/SRPMS/"
  default[:yum][:ruby_19][:enabled]        = false
  default[:yum][:ruby_19][:source_enabled] = false
  default[:yum][:ruby_19][:debug_enabled]  = false
end

# vi:filetype=ruby:tabstop=2:expandtab
