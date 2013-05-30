
# Install IIS and supporting utilities with Chef-solo

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


# Install IIS, msdeploy, 7zip, .NET 4.5 to build an IIS server
$solo_js = @"
{
  "iis": {
    "accept_eula" : true
  },

  "run_list": [
    "recipe[iis]",
    "recipe[iis::mod_deploy]"
    "recipe[7-zip]", 
    "recipe[ms_dotnet45]"
  ]
}
"@


Set-Content -Value $solo_js -Path $chef\solo.js


cd $chef\cookbooks\
git clone git://github.com/opscode-cookbooks/iis.git
git clone git://github.com/opscode-cookbooks/webpi.git
git clone git://github.com/opscode-cookbooks/windows.git
git clone git://github.com/opscode-cookbooks/chef_handler.git
git clone https://github.com/opscode-cookbooks/7-zip
git clone https://github.com/Webtrends/Cookbooks WebTrends


cd $chef
chef-solo -c $chef\solo.rb -j $chef\solo.js -l debug
