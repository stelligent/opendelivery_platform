amazon_s3file node['rabbitmq']['exe']['path'] do
  key node['rabbitmq']['exe']['key']
  bucket node['rabbitmq']['bucket']
  action :create
end

windows_package "RabbitMQ Server" do
  source node['rabbitmq']['exe']['path']
  options '/S'
  installer_type :nsis
  action :install
end
