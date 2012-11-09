class system {
  
  # Install basic packages
  package { "gcc":                 ensure => "installed" }
  package { "mod_proxy_html":      ensure => "installed" }
  package { "perl":                ensure => "installed" }
  package { "libxslt-devel":       ensure => "installed" }
  package { "libxml2-devel":       ensure => "installed" }
  package { "make":                ensure => "installed" }
  package { "gcc-c++":             ensure => "installed" }
  
  # Install basic gems
  package { "bundler":             ensure => "1.1.4",  provider => gem }
  package { "trollop":             ensure => "2.0",    provider => gem }
  package { "aws-sdk":             ensure => "1.5.6",  provider => gem, require => [ Package["gcc"], Package["make"] ] }
  package { "capistrano":          ensure => "2.12.0", provider => gem }
}


