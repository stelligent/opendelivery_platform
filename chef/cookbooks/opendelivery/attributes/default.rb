default['jenkins']['file'] = "jenkins.war"
default['jenkins']['key'] = "3rdParty/#{node['jenkins']['file']}"
default['jenkins']['path'] = "#{node['tomcat']['home']}/webapps/#{node['jenkins']['file']}"

default['opendelivery']['domain'] = node['amazon']['simpledb']['domain']
default['opendelivery']['bucket'] = node['amazon']['s3']['bucket']
default['opendelivery']['chef']['organization'] = ''

default['opendelivery']['gems'] = {
  'bundler'      => '1.1.4',
  'cucumber'     => '1.2.1',
  'net-ssh'      => '2.5.2',
  'rspec'        => '2.10.0',
  'trollop'      => '2.0',
  'rake'         => '0.9.2.2',
  'opendelivery' => '0.0.18'
}

default['opendelivery']['config'] = {
  'PROJECT_NAME'        => node['amazon']['simpledb']['domain'],
  'GIT_PLATFORM_REPO'   => node['git']['platform']['repo'],
  'GIT_PLATFORM_BRANCH' => node['git']['platform']['branch'],
  'GIT_JENKINS_REPO'    => node['git']['jenkins']['repo'],
  'GIT_JENKINS_BRANCH'  => node['git']['jenkins']['branch']
}
