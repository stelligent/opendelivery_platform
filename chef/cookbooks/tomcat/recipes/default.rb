package node['tomcat']['pkg'] do
  action :install
end

directory node['tomcat']['home'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  recursive true
end

service node['tomcat']['service'] do
  action [:enable, :start]
end
