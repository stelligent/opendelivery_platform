include_recipe "java"

aws_s3file node['tomcat']['windows']['path'] do
  key node['tomcat']['windows']['key']
  bucket node['tomcat']['s3']['bucket']
  action :create
end

windows_package node['tomcat']['windows']['name'] do
  source node['tomcat']['windows']['path']
  options node["tomcat"]['windows']['options']
  installer_type :custom
  action :install
end

service node['tomcat']['windows']['service'] do
  action :start
end
