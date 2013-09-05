case node['platform']
when "windows"

  windows_batch "Clone platform repo" do
    code <<-EOH
      set PATH=%PATH%;C:\\Program Files (x86)\\Git\\bin
      git clone "https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['platform']['repo']}.git" Z:\\
    EOH
  end

else

  execute "Clone platform repo" do
    command <<-EOH
      git clone "https://#{node['git']['username']}:#{node['git']['password']}@github.com/#{node['git']['org']}/#{node['git']['platform']['repo']}.git" /tmp/#{node['git']['platform']['repo']}
    EOH
  end
end

aws_simpledb_create node['opendelivery']['domain'] do
  domain node['opendelivery']['domain']
  action :create
end

aws_simpledb_load "Load initial configuration" do
  domain node['opendelivery']['domain']
  json_file node['opendelivery']['setup']['path']
end
