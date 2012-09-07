class groovy {
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
  }
  
  download_file {"groovy-1.8.2.tar.gz":                                                                                                 
      site => "https://s3.amazonaws.com/sea2shore/resources/binaries",                                                                           
      cwd => "/tmp",                                                                            
      creates => "/tmp/groovy-1.8.2.tar.gz",                                                         
  }
  
  file { "/usr/bin/groovy-1.8.2/":
      ensure => "directory",
      owner  => "root",
      group  => "root",
      mode   => 755,
      require => Download_file["groovy-1.8.2.tar.gz"],
  }
  
  exec { "extract-groovy":
    command => "tar -C /usr/bin/groovy-1.8.2/ -xvf /tmp/groovy-1.8.2.tar.gz",
    require => File["/usr/bin/groovy-1.8.2/"],
  }
}
