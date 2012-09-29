class tomcat6 {
  
  package { "tomcat6":
    ensure => "installed" 
  }
  
  service { "tomcat6":
    enable => true,
    require => Package["tomcat6"],
    ensure => running,
  }
}