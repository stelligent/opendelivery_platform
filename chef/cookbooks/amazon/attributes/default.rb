default['amazon']['simpledb']['domain'] = ''
default['amazon']['s3']['bucket'] = ''

default['amazon']['access']['key'] = ''
default['amazon']['secret']['key'] = ''
default['amazon']['region'] = ''

default['amazon']['gem']['version'] = '1.16.0'


case node['platform']
when "windows"
  default['amazon']['setup']['file'] = "platform.json"
  default['amazon']['setup']['path'] = "Z:\\#{node['git']['platform']['repo']['name']}\\config\\#{node['amazon']['setup']['file']}"
else
  default['amazon']['setup']['file'] = "platform.json"
  default['amazon']['setup']['path'] = "/tmp/#{node['git']['platform']['repo']['name']}//config//#{node['amazon']['setup']['file']}"
end
