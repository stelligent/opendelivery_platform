class postgresql {
  
  package { "postgresql8-server":
    ensure => installed,
  }
  
  exec { "initdb": 
    unless => "[ -d /var/lib/postgresql/data ]",
    command => "service postgresql initdb",
    require => Package["postgresql8-server"]
  }
  
  exec { "create-user":
    command => "echo CREATE USER root | psql -U postgres",
    require => Service["postgresql"]
  }
  
  file { "/var/lib/pgsql/data/pg_hba.conf":
      content => template("postgresql/pg_hba.conf.erb"),
      require => Exec["initdb"],
      ensure  => "present",
      owner   => 'postgres',
      group   => 'postgres',
      mode    => '600',
  }
  
  file { "/var/lib/pgsql/data/postgresql.conf":
      content => template("postgresql/postgresql.conf.erb"),
      require => Exec["initdb"],
      ensure  => "present",
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
}