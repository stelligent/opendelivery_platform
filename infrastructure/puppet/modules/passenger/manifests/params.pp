# Class: passenger::params

class passenger::params {
  $version='3.0.18'

  $gem_path = '/usr/lib64/ruby/gems/1.9.1/gems'
  $gem_binary_path = '/usr/lib64/ruby/gems/1.9.1/bin'
  $mod_passenger_location = "/usr/lib64/ruby/gems/1.9.1/gems/passenger-$version/ext/apache2/mod_passenger.so"
}
