
# Install IIS with Chef-solo

$chef = "C:\chef"
$opscode = "C:\opscode"
$git = "C:\Program Files (x86)\Git"

$Env:PATH += ";$opscode\bin;$git\bin"

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
  "iis": {
    "accept_eula" : true
  },

  "run_list": [
    "recipe[iis]",
    "recipe[iis::mod_deploy"
  ]
}
"@


Set-Content -Value $solo_js -Path $chef\solo.js


cd $chef\cookbooks\
git clone git://github.com/opscode-cookbooks/iis.git
git clone git://github.com/opscode-cookbooks/webpi.git
git clone git://github.com/opscode-cookbooks/windows.git
git clone git://github.com/opscode-cookbooks/chef_handler.git
cd $chef
chef-solo -c $chef\solo.rb -j $chef\solo.js -l debug
