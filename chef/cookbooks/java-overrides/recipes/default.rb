amazon_s3file node['java']['windows']['path'] do
  key node['java']['windows']['key']
  bucket node['java']['bucket']
  aws_access_key node['amazon']['access']['key']
  aws_secret_access_key node['amazon']['secret']['key']
  action :create
end

windows_package node['java']['windows']['package_name'] do
  source node['java']['windows']['path']
  options node['java']['windows']['options']
  installer_type :custom
  action :install
end

windows_batch "Set Java Home" do
  code <<-EOH
  setx JAVA_HOME '#{node['java']['windows']['home']}'
  setx JAVA_HOME '#{node['java']['windows']['home']}' /m
  EOH
end
