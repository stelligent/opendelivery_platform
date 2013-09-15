default['jenkins']['url'] = "http://mirrors.jenkins-ci.org/war/1.530/jenkins.war"
default['jenkins']['path'] = "#{node['tomcat']['home']}/webapps/jenkins.war"

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
  'opendelivery' => '0.0.19'
}

default['opendelivery']['config'] = {
  'PROJECT_NAME'        => node['amazon']['simpledb']['domain'],
  'GIT_PLATFORM_REPO'   => node['git']['platform']['repo']['url'],
  'GIT_PLATFORM_BRANCH' => node['git']['platform']['branch'],
  'GIT_JENKINS_REPO'    => node['git']['jenkins']['repo']['url'],
  'GIT_JENKINS_BRANCH'  => node['git']['jenkins']['branch']
}
