
# Install packages with Chef
# Make sure you run "Set-ExecutionPolicy RemoteSigned" first
                 

$chef = "C:\chef"
$opscode = "C:\opscode"

$Env:PATH += ";$opscode\bin"

function installPkg(String $jsRule, String[] $cookbooks)
{
	mkdir -force $chef
  mkdir -force $chef\cache
  mkdir -force $chef\cookbooks
  
  $solo_rb = @"
  file_cache_path File.join(Dir.pwd, 'cache')
  cookbook_path File.join(Dir.pwd, 'cookbooks')
  "@
  Set-Content -Value $solo_rb -Path "$chef\solo.rb"

  Set-Content -Value $jsRule -Path "$chef\solo.js"
  
  cd $chef\cookbooks\
  
  foreach $book in $cookbooks 
  {
    git clone $book
  }
  cd $chef
  chef-solo -c $chef\solo.rb -j $chef\solo.js -l debug
}


// IIS CONFIGURATION
$iisJS = @"
{
  "iis": {
    "accept_eula" : true
  },

  "run_list": [
    "recipe[iis]"
  ]
}
"@

$iisBooks = ["git://github.com/opscode-cookbooks/iis.git",
            "git://github.com/opscode-cookbooks/webpi.git",
            "git://github.com/opscode-cookbooks/windows.git", 
            "git://github.com/opscode-cookbooks/chef_handler.git];
            
installPkg($iisJS, $iisBooks);

$sqlJS = @"
{
  "sql_server": {
    "accept_eula" : true,
    "server" : {
      "url" : "https://s3.amazonaws.com/StelligentLabsResources/binaries/windows/SQLEXPRWT_x64_ENU.exe",
      "checksum" : "ac38a71ed5f480ecd483490fc784a7a5"
    }
  },

  "run_list": [
    "recipe[sql_server::server]"
  ]
}
"@

sqlBooks =  ["http://github.com/opscode-cookbooks/sql_server",
             "http://github.com/opscode-cookbooks/openssl"]
             
installPkg($sqlJS, $sqlBooks);