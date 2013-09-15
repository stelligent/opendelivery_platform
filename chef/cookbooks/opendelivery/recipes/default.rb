jenkins_home = '/usr/share/.jenkins'

remote_file node['jenkins']['path'] do
  source node['jenkins']['url']
  action :create
end

execute "Set Jenkins Home" do
  command <<-EOH
  echo "export JENKINS_HOME=#{jenkins_home}" >> /etc/sysconfig/tomcat6
  EOH
end

directory "#{node['tomcat']['home']}/.ssh" do
  action :create
end

template "git-config" do
  path "#{node['tomcat']['home']}/.ssh/config"
  source "git-config.erb"
end

execute "Setup jenkins repo" do
  only_if do Dir[jenkins_home].empty? end
  command <<-EOH
  git clone https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['jenkins']['repo']['name']}.git #{jenkins_home}
  EOH
end

directory jenkins_home do
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  notifies :restart, resources(:service => "tomcat")
end
