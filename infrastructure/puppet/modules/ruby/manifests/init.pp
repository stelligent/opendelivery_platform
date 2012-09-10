class ruby {
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
  }
  
  download_file {"ruby-1.9.3p0-2.amzn1.x86_64.rpm":                                                                                                 
      site => "https://s3.amazonaws.com/cdplatform/resources/rpm",                                                                           
      cwd => "/tmp",                                                                            
      creates => "/tmp/ruby-1.9.3p0-2.amzn1.x86_64.rpm"                                                            
  }
  
  exec { "ruby":
    require => [ Download_file["ruby-1.9.3p0-2.amzn1.x86_64.rpm"], Package["libxslt-devel"] ],
    command => "rpm -Uvhf /tmp/ruby-1.9.3p0-2.amzn1.x86_64.rpm"
  }
  
  package { "libxslt-devel":       ensure => "installed" }
  # package { "libxml2-devel":       ensure => "installed" }
}
  