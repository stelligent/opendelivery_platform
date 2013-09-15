remote_file node['jenkins']['path'] do
  not_if do File.exists?(node['jenkins']['path']) end
  source node['jenkins']['url']
  action :create
end

execute "Set Jenkins Home" do
  command <<-EOH
  echo "export JENKINS_HOME=#{node['jenkins']['home']}" >> /etc/sysconfig/tomcat6
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
  only_if do Dir[node['jenkins']['home']].empty? end
  command <<-EOH
  git clone https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['jenkins']['repo']['name']}.git #{node['jenkins']['home']}
  chown -R #{node['tomcat']['user']}:#{node['tomcat']['group']} #{node['jenkins']['home']}
  EOH
  notifies :restart, resources(:service => "tomcat")
end
