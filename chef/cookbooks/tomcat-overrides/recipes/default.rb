include_recipe "java-overrides"

amazon_s3file node['tomcat']['windows']['path'] do
  key node['tomcat']['windows']['key']
  bucket node['tomcat']['bucket']
  aws_access_key node['amazon']['access']['key']
  aws_secret_access_key node['amazon']['secret']['key']
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
