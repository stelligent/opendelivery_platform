default['rabbitmq']['bucket'] = node['aws']['s3']['bucket']

case node['platform_family']
when "windows"

  default['rabbitmq']['exe']['file'] = 'rabbitmq-server-3.0.0.exe'
  default['rabbitmq']['exe']['key'] = "3rdParty/#{node['rabbitmq']['exe']['file']}"
  default['rabbitmq']['exe']['path'] = "Z:\\#{node['rabbitmq']['exe']['file']}"
end
