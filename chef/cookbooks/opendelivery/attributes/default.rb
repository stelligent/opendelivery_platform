default['jenkins']['file'] = "jenkins.war"
default['jenkins']['key'] = "3rdParty/#{node['jenkins']['file']}"
default['jenkins']['path'] = "#{node['tomcat']['windows']['home']}/webapps/#{node['jenkins']['file']}"

default['jenkins']['server']['name'] = ""

default['git']['username'] = ""
default['git']['password'] = ""
default['git']['organization'] = ''
default['git']['platform']['repo'] = ''
default['git']['jenkins']['repo'] = ''


default['opendelivery']['domain'] = node['jenkins']['server']['name']
default['opendelivery']['bucket'] = node['aws']['s3']['bucket']
default['opendelivery']['chef']['organization'] = ''

default['opendelivery']['setup']['file'] = "platform.json"
default['opendelivery']['setup']['path'] = "Z:\\atlas_platform\\config\\#{node['opendelivery']['setup']['file']}"

default['opendelivery']['platform']['repo'] = "https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['organization']}/#{node['git']['platform']['repo']}.git"
default['opendelivery']['jenkins']['repo'] = "https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['organization']}/#{node['git']['jenkins']['repo']}.git"


default['opendelivery']['gems'] = {
  'bundler'    => '1.1.4',
  'cucumber'   => '1.2.1',
  'net-ssh'    => '2.5.2',
  'capistrano' => '2.12.0',
  'route53'    => '0.2.1',
  'rspec'      => '2.10.0',
  'trollop'    => '2.0',
  'rake'       => '0.9.2.2'
}

default['opendelivery']['config'] = {
  'PROJECT_NAME' => node['jenkins']['server']['name']
}

default['common-step-definitions']['source'] = 'C:\Downloads\common-step-definitions-1.0.0.gem'
