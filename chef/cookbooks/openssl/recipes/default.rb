aws_s3file node['openssl']['path'] do
  key node['openssl']['key']
  bucket node['openssl']['bucket']
  action :create
end

windows_zipfile 'C:\openssl' do
  source node['openssl']['path']
  action :unzip
  overwrite true
end
