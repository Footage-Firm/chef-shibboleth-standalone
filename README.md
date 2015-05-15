# chef-shibboleth-standalone

## Note
This is a simple webserver-independent fork of [wharton/chef-shibboleth-sp](https://github.com/wharton/chef-shibboleth-sp)

## Description

Installs/Configures Shibboleth Service Provider.

## Requirements

### Platforms

* CentOS 6
* RedHat 6
* Ubuntu 12.04 (Precise)
* Windows 2008 R2 64-bit

### Cookbooks

* windows
* yum

## Attributes

* `node['shibboleth-standalone']['version']` - Version of shibboleth-standalone to
  install (if Windows or from source).
* `node['shibboleth-standalone']['user']` - Shibboleth-sp user.

### Simple Attribute-Driven Configuration Attributes

* `node['shibboleth-standalone']['Errors']['supportContact']` - admin email, defaults
  to "root@FQDN"
* `node['shibboleth-standalone']['Errors']['helpLocation']` - help url, defaults
  to "/about.html"
* `node['shibboleth-standalone']['Errors']['styleSheet']` - stylesheet url, defaults
  to "/shibboleth-standalone/main.css"
* `node['shibboleth-standalone']['Errors']['logoLocation']` - logo url, defaults
  to "/shibboleth-standalone/logo.jpg"
* `node['shibboleth-standalone']['entityID']` - SP entity URL, defaults to 
  https://FQDN/shibboleth
* `node['shibboleth-standalone']['REMOTE_USER']` - REMOTE_USER data returned to web
  server, defaults to "eppn persistent-id targeted-id"
* `node['shibboleth-standalone']['sign-messages']` - "true", "false", "front", or
  "back", whether to sign outgoing messages, defaults to "false"
* `node['shibboleth-standalone']['Sessions']['checkAddress']` - check source address,
  breaks with NAT/proxy, defaults to "false"
* `node['shibboleth-standalone']['Sessions']['cookieProps']` - cookie properties,
  defaults to "; path=/; HttpOnly"
* `node['shibboleth-standalone']['Sessions']['handlerSSL']` - only SSL requests will be
  handled, defaults to "false"
* `node['shibboleth-standalone']['Sessions']['lifetime']` - defaults to 28800
* `node['shibboleth-standalone']['Sessions']['relayState']` - defaults to "ss:mem"
* `node['shibboleth-standalone']['Sessions']['timeout']` - defaults to 3600
* `node['shibboleth-standalone']['saml-query']` - defaults to `true`
* `node['shibboleth-standalone']['SSO']['entityID']` - single IdP entity URL,
  _must_ be set to your IdP unless using `node['shibboleth-standalone']['SSO']['discoveryURL']`
* `node['shibboleth-standalone']['SSO']['discoveryProtocol']` - Multiple IdP Discovery
  Service Protocol, defaults to "SAMLDS", another protocol is "WAYF"
* `node['shibboleth-standalone']['SSO']['discoveryURL']` - Multiple IdP Discovery
  Service URL, will override `node['shibboleth-standalone']['SSO']['entityID']`
* `node['shibboleth-standalone']['Hanlder']['Status']['acl']` - IPs that can access the
  status handler. Defaults to `127.0.0.1 ::1`. If set to a blank string no acl
  is applied.
* `node['shibboleth-standalone']['Handler']['MetadataGenerator']
['childElements']` - Child elements to add to the generated metadata.
* `node['shibboleth-standalone']['attribute-map']['name-id']` - A hash with the NameID
  name and id to map from the IdP.
* `node['shibboleth-standalone']['MetadataProvider']['path']` - Path to IdP metadata file.
* `node['shibboleth-standalone']['MetadataProvider']['url']` - URL of IdP metadata file.
* `node['shibboleth-standalone']['MetadataProvider']['backingFilePath']` - Path to cach a
  copy of the IdP metadata if using a URL.
* `node['shibboleth-standalone']['MetadataProvider']['reloadInterval']` - Interval to
  check for metadata updates. 
* `node['shibboleth-standalone']['attribute-map']['attributes']` - An array of hashs 
  with the name (required), id (required), and nameFormat (optional) of 
  attirbutes to map from the IdP.

### Logging Attributes

For shibd.logger (all default to INFO):
* `node['shibboleth-standalone']['logging']['root']` - root log level
* `node['shibboleth-standalone']['logging']['OpenSAML']['MessageDecoder']`
* `node['shibboleth-standalone']['logging']['OpenSAML']['MessageEncoder']`
* `node['shibboleth-standalone']['logging']['OpenSAML']['SecurityPolicyRule']`
* `node['shibboleth-standalone']['logging']['Shibboleth']['Listener']`
* `node['shibboleth-standalone']['logging']['Shibboleth']['RequestMapper']`
* `node['shibboleth-standalone']['logging']['Shibboleth']['SessionCache']`
* `node['shibboleth-standalone']['logging']['XMLTooling']['libcurl']`
* `node['shibboleth-standalone']['logging']['XMLTooling']['Signature']`
* `node['shibboleth-standalone']['logging']['XMLTooling']['SOAPClient']`
* `node['shibboleth-standalone']['logging']['XMLTooling']['StorageService']`

### Web Server Specific Attributes

### Platform Specific Attributes

* `node['shibboleth-standalone']['redhat']['use_rhn']` - Use RHN-synchronized repository
  for shibboleth installation
* `node['shibboleth-standalone']['windows']['url']` - URL for Windows shibboleth-standalone.
* `node['shibboleth-standalone']['windows']['checksum']` - Checksum for Windows
  shibboleth-standalone.

## Recipes

* `recipe[shibboleth-standalone]` Installs and enables base Shibboleth Service
  Provider.
* `recipe[shibboleth-standalone::simple]` Base recipe and simple attribute-driven configuration.
* `recipe[shibboleth-standalone::sp_cert_key]` Recipe to configure sp cert and key using data bags or node attributes.

## Usage

For just installation and enabling the Shibboleth Service Provider, just add
`recipe[shibboleth-standalone]` to your run list. The other recipes are modular for
specific configuration scenarios.

### Simple Attribute-Driven Configuration

Using `recipe[shibboleth-standalone::simple]` gives you a basic attribute-driven model
for configuring simple Shibboleth SPs. Anything beyond the givem attributes,
you are probably better off writing a custom site cookbook, outlined below.

### Custom Shibboleth SP Configuration

Use `recipe[shibboleth-standalone]` and create a site cookbook that uses cookbook_files
or templates to overwrite files in the Shibboleth SP directory.

### SP Certificate and Key

The certificate and key used by your SP for signing and encryption will be generated when the SP software is installed. You can choose to use your own certificate for this purpose by using the `shibboleth-standalone::sp_cert_key` recipe. This recipe will check for a data bag item `shibboleth.sp` with a key matching the `node['shiboboleth-sp']['entityID']`. If that does not exits it will check for a key matching the chef environment (or `local` for chef-solo). Finally if the data bag does not exist or there are no matching keys the recipe will look to the `node['shibboleth-standalone']['cert']` and `node['shibboleth-standalone']['key']` attributes.
