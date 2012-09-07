class tomcat6 {
  
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  package { "tomcat6":
    ensure => "installed" 
  }
  
  $backup_directories = [ 
    "/usr/share/tomcat6/.sarvatix/", 
    "/usr/share/tomcat6/.sarvatix/manatees/",
    "/usr/share/tomcat6/.sarvatix/manatees/wildtracks/", 
    "/usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/", 
    "/usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/backup_archive",
  ]

  file { $backup_directories:
      ensure => "directory",
      owner  => "tomcat",
      group  => "tomcat",
      mode   => 777,
      require => Package["tomcat6"],
  }
  
  service { "tomcat6":
        enable => true,
        require => [ 
          File[$backup_directories],
          Package["tomcat6"]],
          ensure => running,
  }
}