class mysql {
 
  package { 'mysql-devel':
    ensure => installed,
  }
  
  package { 'mysql':
     ensure => installed,
   }
}