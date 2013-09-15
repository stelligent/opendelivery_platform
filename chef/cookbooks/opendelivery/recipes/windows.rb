path = win_friendly_path( ::File.join( node['tomcat']['home'],'.jenkins'))

remote_file node['jenkins']['path'] do
  source node['jenkins']['url']
  action :create
end

windows_batch "Set Jenkins Home" do
  code <<-EOH
  setx JENKINS_HOME #{path} /m
  setx JENKINS_HOME #{path}
  EOH
end

directory "#{node['tomcat']['home']}/.ssh" do
  action :create
end

template "git-config" do
  path "#{node['tomcat']['home']}/.ssh/config"
  source "git-config.erb"
end

windows_batch "Setup jenkins repo" do
  code <<-EOH
  set PATH=%PATH%;C:\\Program Files (x86)\\Git\\bin
  git clone https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['jenkins']['repo']}.git #{path}
  EOH
end
