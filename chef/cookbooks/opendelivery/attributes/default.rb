default['jenkins']['file'] = "jenkins.war"
default['jenkins']['key'] = "3rdParty/#{node['jenkins']['file']}"
default['jenkins']['path'] = "#{node['tomcat']['home']}/webapps/#{node['jenkins']['file']}"

default['jenkins']['server']['name'] = ""

default['git']['username'] = ""
default['git']['password'] = ""
default['git']['org'] = ''
default['git']['platform']['repo'] = ''
default['git']['jenkins']['repo'] = ''

default['opendelivery']['domain'] = node['jenkins']['server']['name']
default['opendelivery']['bucket'] = node['aws']['s3']['bucket']

default['opendelivery']['gems'] = {
  'bundler'    => '1.1.4',
  'cucumber'   => '1.2.1',
  'net-ssh'    => '2.5.2',
  'rspec'      => '2.10.0',
  'trollop'    => '2.0',
  'rake'       => '0.9.2.2'
}

default['opendelivery']['config'] = {
  'PROJECT_NAME' => node['jenkins']['server']['name']
}

default['opendelivery']['setup']['file'] = "platform.json"

case node['platform']
when "windows"
  default['opendelivery']['setup']['path'] = "Z:\\#{node['git']['platform']['repo']}\\config\\#{node['opendelivery']['setup']['file']}"
else
  default['opendelivery']['setup']['path'] = "/tmp/#{node['git']['platform']['repo']}\\config\\#{node['opendelivery']['setup']['file']}"
end
