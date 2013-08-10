path = win_friendly_path( ::File.join( node['tomcat']['windows']['home'],'.jenkins'))

aws_s3file node['jenkins']['path'] do
  key node['jenkins']['key']
  bucket node['opendelivery']['bucket']
  action :create
end

windows_batch "Set Jenkins Home" do
  code <<-EOH
  setx JENKINS_HOME #{path} /m
  setx JENKINS_HOME #{path}
  EOH
end

directory "#{node['tomcat']['windows']['home']}/.ssh" do
  action :create
end

template "git-config" do
  path "#{node['tomcat']['windows']['home']}/.ssh/config"
  source "git-config.erb"
end

windows_batch "Setup jenkins repo" do
  code <<-EOH
  set PATH=%PATH%;C:\\Program Files (x86)\\Git\\bin
  git clone #{node['opendelivery']['jenkins']['repo']} #{path}
  EOH
end

ruby_block "Update config.xml for each jenkins job" do
  block do

    job_config_files = Dir['c:\tomcat\.jenkins\jobs\**\config.xml']
    job_config_files.each do |config|
      text = File.read(config)
      output_of_gsub = text.gsub('git@github.com:stelligent/continuous_delivery_open_platform.git', node['opendelivery']['platform']['repo'] )
      File.open(config, "w") {|file| file.puts output_of_gsub}
    end
  end
  notifies :restart, "service[#{node['tomcat']['windows']['service']}]"
end
