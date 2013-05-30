# Install IIS with Chef-solo

$chef = "C:\chef"
$opscode = "C:\opscode"

$Env:PATH += ";$opscode\bin"

mkdir -force $chef
mkdir -force $chef\cache
mkdir -force $chef\cookbooks

$solo_rb = @"
file_cache_path File.join(Dir.pwd, 'cache')
cookbook_path File.join(Dir.pwd, 'cookbooks')
"@
Set-Content -Value $solo_rb -Path $chef\solo.rb

$solo_js = @"
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
Set-Content -Value $solo_js -Path $chef\solo.js

cd $chef\cookbooks\
git clone http://github.com/opscode-cookbooks/sql_server
git clone http://github.com/opscode-cookbooks/openssl

cd $chef
chef-solo -c $chef\solo.rb -j $chef\solo.js -l debug
