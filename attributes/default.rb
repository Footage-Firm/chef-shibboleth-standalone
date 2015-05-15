#
# Cookbook Name:: shibboleth-standalone
# Attributes:: shibboleth-standalone
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

default['shibboleth-standalone']['version'] = "2.5.0"

default['shibboleth-standalone']['Errors']['supportContact'] = "root@#{node['fqdn']}"
default['shibboleth-standalone']['Errors']['helpLocation'] = "/about.html"
default['shibboleth-standalone']['Errors']['styleSheet'] = "/shibboleth-standalone/main.css"
default['shibboleth-standalone']['Errors']['logoLocation'] = "/shibboleth-standalone/logo.jpg"
default['shibboleth-standalone']['entityID'] = "https://#{node['fqdn']}/shibboleth"
default['shibboleth-standalone']['REMOTE_USER'] = "eppn persistent-id targeted-id"
default['shibboleth-standalone']['sign-messages'] = "false"
#default['shibboleth-standalone']['attributePrefix'] = "AJP_"
default['shibboleth-standalone']['Sessions']['checkAddress'] = "false"
default['shibboleth-standalone']['Sessions']['cookieProps'] = "; path=/; HttpOnly"
default['shibboleth-standalone']['Sessions']['handlerSSL'] = "false"
default['shibboleth-standalone']['Sessions']['lifetime'] = 28800
default['shibboleth-standalone']['Sessions']['relayState'] = "ss:mem"
default['shibboleth-standalone']['Sessions']['timeout'] = 3600
default['shibboleth-standalone']['saml-query'] = true

# Single IdP (overrode by ['SSO']['discoveryURL'])
default['shibboleth-standalone']['SSO']['entityID'] = "https://idp.example.org/idp/shibboleth"
default['shibboleth-standalone']['SSO']['discoveryProtocol'] = "SAMLDS"

# Multiple IdP Discovery (overrides ['SSO']['entityID'])
default['shibboleth-standalone']['SSO']['discoveryURL'] = ""

# Status Handler ACL
default['shibboleth-standalone']['Handler']['Status']['acl'] = "127.0.0.1 ::1"

# Metadata Handler Child Elements
default['shibboleth-standalone']['Handler']['MetadataGenerator']['childElements'] = nil

# Logging
default['shibboleth-standalone']['logging']['root'] = "INFO"
default['shibboleth-standalone']['logging']['OpenSAML']['MessageDecoder'] = nil
default['shibboleth-standalone']['logging']['OpenSAML']['MessageEncoder'] = nil
default['shibboleth-standalone']['logging']['OpenSAML']['SecurityPolicyRule'] = nil
default['shibboleth-standalone']['logging']['Shibboleth']['Listener'] = nil
default['shibboleth-standalone']['logging']['Shibboleth']['RequestMapper'] = nil
default['shibboleth-standalone']['logging']['Shibboleth']['SessionCache'] = nil
default['shibboleth-standalone']['logging']['XMLTooling']['libcurl'] = nil
default['shibboleth-standalone']['logging']['XMLTooling']['Signature'] = "INFO"
default['shibboleth-standalone']['logging']['XMLTooling']['SOAPClient'] = nil
default['shibboleth-standalone']['logging']['XMLTooling']['StorageService'] = nil

# Metadata Provider
# default['shibboleth-standalone']['MetadataProvider']['path'] = ""
# default['shibboleth-standalone']['MetadataProvider']['url'] = ""
# default['shibboleth-standalone']['MetadataProvider']['backingFilePath'] = ""
# default['shibboleth-standalone']['MetadataProvider']['reloadInterval'] = ""

# SAML attributes for attribute-map.xml
# default['shibboleth-standalone']['attribute-map']['name-id'] = { "name" => "emailAddress", "id" => "emailAddress" }
# default['shibboleth-standalone']['attribute-map']['attributes'] = [
	# {"name" => "firstName", "id" => "firstName", "nameFormat" => "basic"},
	# {"name" => "lastName", "id" => "lastName", "nameFormat" => "basic"}
# ]

# Platform specific customizations
case node['platform']
when 'windows'
  default['shibboleth-standalone']['dir'] = "C:/opt/shibboleth-standalone/etc/shibboleth"
  default['shibboleth-standalone']['windows']['url']      = "http://shibboleth.net/downloads/service-provider/latest/win64/shibboleth-standalone-#{node['shibboleth-standalone']['version']}-win64.msi"
  default['shibboleth-standalone']['windows']['checksum'] = "d40431e3b4f2aff8ae035f2a434418106900ea6d9a7d06b2b0c2e9a30119b54c"
  default['shibboleth-standalone']['user'] = "shibd"
when 'centos','redhat'
  default['shibboleth-standalone']['dir'] = "/etc/shibboleth"
  default['shibboleth-standalone']['redhat']['use_rhn'] = false
  default['shibboleth-standalone']['user'] = "shibd"
when 'ubuntu','debian'
  default['shibboleth-standalone']['dir'] = "/etc/shibboleth"
  default['shibboleth-standalone']['user'] = "_shibd"
else 
  default['shibboleth-standalone']['dir'] = "/etc/shibboleth"
  default['shibboleth-standalone']['user'] = "shibd"
end



