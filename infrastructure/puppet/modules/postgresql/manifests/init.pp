class postgresql {
  
  include params
  
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
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
}