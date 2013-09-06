name              "java-overrides"
maintainer        "Stelligent Systems LLC"
license           "Apache 2.0"
description       "Installs Java runtime."
version           "1.11.7"

%w{ windows }.each do |os|
  supports os
end

depends "windows"
depends "powershell"
depends "amazon"
