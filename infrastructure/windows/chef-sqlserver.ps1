# Install SQL Server with Chef-solo
pushd C:\

$chef = "C:\chef"
$opscode = "C:\opscode"
$git = "C:\Program Files (x86)\Git"

$Env:PATH += ";$opscode\bin;$git\bin"

mkdir -force $chef
mkdir -force $chef\cache
mkdir -force $chef\cookbooks

$solo_rb = @"
file_cache_path File.join(Dir.pwd, 'cache')
cookbook_path [File.join(Dir.pwd, 'cookbooks'), File.join(Dir.pwd, 'cookbooks\WebTrends')]
"@
Set-Content -Value $solo_rb -Path $chef\solo.rb


# This installs SQL express. To install "Standard", need to add product key and link to correct media.
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
    "recipe[7-zip]", 
    "recipe[ms_dotnet4]",
    "recipe[sql_server::server]"
  ]
}
"@
Set-Content -Value $solo_js -Path $chef\solo.js

cd $chef\cookbooks\
git clone http://github.com/opscode-cookbooks/sql_server
git clone http://github.com/opscode-cookbooks/openssl

git clone git://github.com/opscode-cookbooks/windows.git
git clone git://github.com/opscode-cookbooks/chef_handler.git
git clone https://github.com/opscode-cookbooks/7-zip
git clone https://github.com/Webtrends/Cookbooks WebTrends

cd $chef
chef-solo --no-color -c $chef\solo.rb -j $chef\solo.js -l debug

popd
