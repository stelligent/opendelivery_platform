class httpd {
 
  package { 'httpd-devel':
    ensure => installed,
  }
  
  service { 'httpd':
    ensure    => running,
    enable    => true,
    require => Package["httpd-devel"]
  }  
}