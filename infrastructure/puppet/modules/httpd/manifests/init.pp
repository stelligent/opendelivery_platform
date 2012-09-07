class httpd {
  include params
  
  $application_name = $params::application_name
  $hosted_zone = $params::hosted_zone
  
  package { 'httpd':
    ensure => installed,
  }
  
  file { "/etc/httpd/conf/httpd.conf":
      content => template("httpd/httpd.conf.erb"),
      require => Package["httpd"],
      owner   => 'ec2-user',
      group   => 'ec2-user',
      mode    => '664',
  }
  
  service { 'httpd':
    ensure    => running,
    enable    => true,
    require => [
      Package["httpd"], 
      File["/etc/httpd/conf/httpd.conf"]],
    subscribe => Package['httpd'],
  }  
}