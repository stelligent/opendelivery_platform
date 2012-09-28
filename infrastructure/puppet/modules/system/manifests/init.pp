class system {
  
  include params
  
  # Set paramteres from params.pp manifest
  $access_key = $params::access_key
  $secret_access_key = $params::secret_access_key
  
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
  
  define download_file($site="",$cwd="",$creates=""){                                                                                         
    exec { $name:                                                                                                                     
      command => "wget ${site}/${name}",                                                         
      cwd => $cwd,
      creates => "${cwd}/${name}"                                                                                       
    }
  }
  
  # Install basic packages
  package { "gcc":                 ensure => "installed" }
  package { "mod_proxy_html":      ensure => "installed" }
  package { "perl":                ensure => "installed" }
  package { "libxslt-devel":       ensure => "installed" }
  package { "libxml2-devel":       ensure => "installed" }
  package { "make":                ensure => "installed" }
  
  # Install basic gems
  package { "bundler":             ensure => "1.1.4", provider => gem }
  package { "trollop":             ensure => "2.0",   provider => gem }
  package { "aws-sdk":             ensure => "1.5.6", provider => gem, require => [ Package["gcc"], Package["make"] ] }
  
  file { "/home/ec2-user/aws.config":
      content => template("system/aws.config.erb"),
      owner   => 'ec2-user',
      group   => 'ec2-user',
      mode    => '500',
  }
  
  exec {"authorized_keys":
    command => "cat /tmp/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys"                                                       
  }
}


