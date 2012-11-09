class passenger {
  include passenger::install
  include httpd
  
  Class['httpd'] -> Class['passenger::install'] 
}