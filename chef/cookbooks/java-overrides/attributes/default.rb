case node['platform_family']
when "windows"
  default['java']['bucket'] = 'AdventResources'
  default['java']['install_flavor'] = "windows"
  default['java']['windows']['package_name'] = "Java(TM) SE Development Kit 7 (64-bit)"
  default['java']['windows']['home'] = 'C:\java\jre7'
  default['java']['windows']['options'] = "/s INSTALLDIR=#{node['java']['windows']['home']}"

  default['java']['windows']['file'] = 'jre-7-windows-x64.exe'
  default['java']['windows']['key'] = "3rdParty/#{node['java']['windows']['file']}"
  default['java']['windows']['path'] = "Z:\\#{node['java']['windows']['file']}"
end
