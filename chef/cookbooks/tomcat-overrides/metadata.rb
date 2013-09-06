name              "tomcat-overrides"
maintainer        "Brian Jakovich"
maintainer_email  "brian.jakovich@stelligent.com"
license           "Apache 2.0"
description       "Installs and configures Tomcat for Windows"

version           "1.0.0"

%w{ java-overrides windows amazon }.each do |cb|
  depends cb
end
