#
# Cookbook Name:: shibboleth-standalone
# Recipe:: simple
#
# Copyright 2012
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

include_recipe "shibboleth-standalone"

template "#{node['shibboleth-standalone']['dir']}/attribute-map.xml" do
	source "attribute-map.xml.erb"
	owner "root" unless platform? 'windows'
	group "root" unless platform? 'windows'
	mode "0644"
	notifies :restart, "service[shibd]", :delayed
end

template "#{node['shibboleth-standalone']['dir']}/shibboleth2.xml" do
	source "shibboleth2.xml.erb"
	owner "root" unless platform? 'windows'
	group "root" unless platform? 'windows'
	mode "0644"
	notifies :restart, "service[shibd]", :delayed
end

template "#{node['shibboleth-standalone']['dir']}/shibd.logger" do
	source "shibd.logger.erb"
	owner "root" unless platform? 'windows'
	group "root" unless platform? 'windows'
	mode "0644"
	notifies :restart, "service[shibd]", :delayed
end
