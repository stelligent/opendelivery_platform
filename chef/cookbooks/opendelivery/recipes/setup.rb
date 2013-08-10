aws_simpledb_create node['opendelivery']['domain'] do
  domain node['opendelivery']['domain']
  action :create
end

windows_batch "Clone platform repo" do
  code <<-EOH
  Z:
  set PATH=%PATH%;C:\\Program Files (x86)\\Git\\bin
  git clone #{node['opendelivery']['platform']['repo']}
  EOH
end

aws_simpledb_load "Load initial configuration" do
  domain node['opendelivery']['domain']
  json_file node['opendelivery']['setup']['path']
end
