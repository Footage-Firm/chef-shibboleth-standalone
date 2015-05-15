name              "shibboleth-standalone"
maintainer        "The Wharton School - The University of Pennsylvania"
maintainer_email  "chef-admins@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs/Configures Shibboleth Service Provider"
version           "0.4.1"
recipe            "shibboleth-standalone", "Installs and enables base Shibboleth Service Provider."
recipe            "shibboleth-standalone::simple", "Base recipe and simple attribute-driven configuration."
recipe            "shibboleth-standalone::sp_cert_key", "Recipe to configure sp cert and key using databags or node attributes."
depends           "yum", ">= 3.0.0"

%w{ windows }.each do |d|
  depends d
end

%w{ centos redhat ubuntu windows }.each do |os|
  supports os
end
