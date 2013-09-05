name              "opendelivery"
maintainer        "Brian Jakovich"
maintainer_email  "brian.jakovich@stelligent.com"
license           "Apache 2.0"
description       "Installs and configures Open Delivery implementations"

version           "1.0.0"
recipe            "opendelivery", "Main installation"

%w{ powershell git tomcat aws windows }.each do |cb|
  depends cb
end
