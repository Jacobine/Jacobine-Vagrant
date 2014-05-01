#
# Cookbook Name:: build-essential
# Recipe:: debian
#
# Copyright 2008-2013, Opscode, Inc.
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

# Bug: COOK-4534
# See https://github.com/opscode-cookbooks/build-essential/pull/32
execute 'apt-get-update-build-essentials' do
  command 'apt-get update'
  action :nothing
  # tip: to suppress this running every time, just use the apt cookbook
  not_if do
    ::File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    ::File.mtime('/var/lib/apt/periodic/update-success-stamp') > Time.now - 86_400 * 2
  end
end.run_action(:run) if node['build-essential']['compile_time']

potentially_at_compile_time do
  package 'autoconf'
  package 'binutils-doc'
  package 'bison'
  package 'build-essential'
  package 'flex'
  package 'gettext'
  package 'ncurses-dev'
end
