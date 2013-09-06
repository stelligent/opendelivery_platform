amazon_simpledb_create node['amazon']['simpledb']['domain'] do
  domain node['amazon']['simpledb']['domain']
  aws_access_key node['amazon']['access']['key']
  aws_secret_access_key node['amazon']['secret']['key']
  region node['amazon']['region']
  action :create
end
