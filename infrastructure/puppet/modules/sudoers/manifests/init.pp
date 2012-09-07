class sudoers {
  file { "/etc/sudoers":
      content => template("sudoers/sudoers.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '440',
  }
}