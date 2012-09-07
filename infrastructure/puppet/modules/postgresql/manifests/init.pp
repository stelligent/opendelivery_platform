class postgresql {
  
  include params
  
  $jenkins_internal_ip = $params::jenkins_internal_ip
  
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
  }
  
  download_file {"wildtracks.sql":                                                                                                 
      site => "https://s3.amazonaws.com/sea2shore",                                                                           
      cwd => "/tmp",                                                                            
      creates => "/tmp/wildtracks.sql"                                                            
  }
  
  download_file {"createDbAndOwner.sql":                                                                                                 
      site => "https://s3.amazonaws.com/sea2shore",                                                                           
      cwd => "/tmp",                                                                            
      creates => "/tmp/createDbAndOwner.sql"                                                            
  }
  
  package { "postgresql8-server":
    ensure => installed,
  }
  
  exec { "initdb":
    command => "service postgresql initdb",
    require => Package["postgresql8-server"]
  }
  
  file { "/var/lib/pgsql/data/pg_hba.conf":
      content => template("postgresql/pg_hba.conf.erb"),
      require => Exec["initdb"],
      owner   => 'postgres',
      group   => 'postgres',
      mode    => '600',
  }
  
  file { "/var/lib/pgsql/data/postgresql.conf":
      content => template("postgresql/postgresql.conf.erb"),
      require => Exec["initdb"],
      owner   => 'postgres',
      group   => 'postgres',
      mode    => '600',
  }
  
  service { "postgresql":
        enable => true,
        require => [ 
          Exec["initdb"], 
          File["/var/lib/pgsql/data/postgresql.conf"], 
          File["/var/lib/pgsql/data/pg_hba.conf"]],
          ensure => running,
  }
  
  exec { "create-user":
    command => "echo CREATE USER root | psql -U postgres",
    require => Service["postgresql"]
  }
  
  exec { "create-db-owner":
    require => [ 
      Download_file["createDbAndOwner.sql"], 
      Exec["create-user"], 
      Service["postgresql"]],
    command => "psql < /tmp/createDbAndOwner.sql -U postgres"
  }
  
  exec { "load-database":
    require => [ 
      Download_file["wildtracks.sql"], 
      Exec["create-user"], 
      Service["postgresql"], 
      Exec["create-db-owner"]],
    command => "psql -U manatee_user -d manatees_wildtrack -f /tmp/wildtracks.sql"
  } 
}