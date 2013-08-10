name              "tomcat"
maintainer        "Brian Jakovich"
maintainer_email  "brian.jakovich@stelligent.com"
license           "Apache 2.0"
description       "Installs and configures Tomcat"

version           "1.0.0"

%w{ java windows aws }.each do |cb|
  depends cb
end
