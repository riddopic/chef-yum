#
# Cookbook Name:: yum
# Attributes:: scientific
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

if node[:platform] == 'scientific'
  Chef::Log.debug "Including attribute yum::scientific"

  %w[
    sl
    security
    source
    fastbugs
    debuginfo
    testing
    testing_source
  ].each { |r| default[:yum][:repos] << r }

  default[:yum][:sl][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/os/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/$basearch/os/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/$basearch/os/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/os/
  ]
  default[:yum][:sl][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:sl][:enabled] = true

  default[:yum][:security][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/security/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/security/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/security/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/security/
  ]
  default[:yum][:security][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:security][:enabled] = true

  default[:yum][:source][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/SRPMS/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/SRPMS/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/SRPMS/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/SRPMS/
  ]
  default[:yum][:source][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:source][:enabled] = false

  default[:yum][:fastbugs][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/fastbugs/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/fastbugs/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/fastbugs/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/$basearch/updates/fastbugs/
  ]
  default[:yum][:fastbugs][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:fastbugs][:enabled] = false

  default[:yum][:debuginfo][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/archive/debuginfo/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/archive/debuginfo/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/archive/debuginfo/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/archive/debuginfo/
  ]
  default[:yum][:debuginfo][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:debuginfo][:enabled] = false

  default[:yum][:testing][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/testing/$basearch/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/testing/$basearch/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/testing/$basearch/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/testing/$basearch/
  ]
  default[:yum][:testing][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:testing][:enabled] = false

  default[:yum][:testing_source][:baseurl] = %w[
    http://ftp.scientificlinux.org/linux/scientific/$releasever/testing/SRPMS/
    http://ftp1.scientificlinux.org/linux/scientific/$releasever/testing/SRPMS/
    http://ftp2.scientificlinux.org/linux/scientific/$releasever/testing/SRPMS/
    ftp://ftp.scientificlinux.org/linux/scientific/$releasever/testing/SRPMS/
  ]
  default[:yum][:testing_source][:gpgkey] = %w[
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl
    file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson
  ]
  default[:yum][:testing_source][:enabled] = false
end

# vi:filetype=ruby:tabstop=2:expandtab
