remote_file node['jenkins']['path'] do
  source node['jenkins']['url']
  action :create
end

directory "#{node['tomcat']['home']}/.ssh" do
  action :create
end

template "git-config" do
  path "#{node['tomcat']['home']}/.ssh/config"
  source "git-config.erb"
end

execute "Setup jenkins repo" do
  command <<-EOH
  git clone https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['jenkins']['repo']['name']}.git #{node['tomcat']['home']}/.jenkins
  EOH
end
