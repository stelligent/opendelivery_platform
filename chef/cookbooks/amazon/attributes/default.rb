default['amazon']['simpledb']['domain'] = ''
default['amazon']['s3']['bucket'] = ''

default['amazon']['access']['key'] = ''
default['amazon']['secret']['key'] = ''
default['amazon']['region'] = ''


default['amazon']['setup']['file'] = ""
default['amazon']['setup']['path'] = "z:\\#{node['git']['platform']['repo']['name']}\\config\\#{node['amazon']['setup']['file']}"

default['amazon']['gem']['version'] = '1.16.0'
