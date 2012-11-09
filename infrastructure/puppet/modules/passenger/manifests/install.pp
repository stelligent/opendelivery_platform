# Class: passenger
# This class installs passenger

class passenger::install {
  
  include passenger::params
  
  $version = $passenger::params::version

  package { 'passenger':      name => 'passenger', ensure => '3.0.18', provider => 'gem' }
  package { 'openssl-devel':  ensure => 'installed' }
  package { 'libcurl-devel':  ensure => 'installed' }

  exec {'compile-passenger':
    command => 'passenger-install-apache2-module -a',
    require => Package['passenger', 'libcurl-devel', 'openssl-devel']
  }
  
  file { '/etc/httpd/conf.d/passenger.conf':
      content => template('passenger/passenger.erb'),
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '500',
      require => Exec['compile-passenger']
  }
}
