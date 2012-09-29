class Post {
  
  include params
  
  $application_name = $params::application_name
  $hosted_zone = $params::hosted_zone
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
  }
  
  exec {"authorized_keys":
    command => "cat /tmp/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys"                                                       
  }
  
  file { "/etc/httpd/conf/httpd.conf":
      notify => Service['httpd::httpd'],
      content => template("post/httpd.conf.erb"),
      ensure  => "present",
      owner   => 'ec2-user',
      group   => 'ec2-user',
      mode    => '664'
  }
}