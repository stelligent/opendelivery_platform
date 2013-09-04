directory "#{node['tomcat']['windows']['home']}/.ssh" do
  action :create
end

template "git-config" do
  path "#{node['tomcat']['windows']['home']}/.ssh/config"
  source "git-config.erb"
end

execute "Setup jenkins repo" do
  command <<-EOH
  git clone https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['jenkins']['repo']}.git #{node['tomcat']['home']}/.jenkins
  EOH
end

ruby_block "Update config.xml for each jenkins job" do
  block do

    job_config_files = Dir["#{node['tomcat']['home']}/.jenkins/jobs/**/config.xml"]
    job_config_files.each do |config|
      text = File.read(config)
      output_of_gsub = text.gsub('git@github.com:stelligent/continuous_delivery_open_platform.git', "https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['platform']['repo']}.git" )
      File.open(config, "w") {|file| file.puts output_of_gsub}
    end
  end
  notifies :restart, "service[#{node['tomcat']['service']}]"
end
