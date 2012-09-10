class tomcat6 {
  
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  package { "tomcat6":
    ensure => "installed" 
  }
  
  service { "tomcat6":
    enable => true,
    require => Package["tomcat6"],
    ensure => running,
  }
}