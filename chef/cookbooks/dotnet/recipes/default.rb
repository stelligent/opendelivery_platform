aws_s3file node['dotnet']['update']['path'] do
  key node['dotnet']['update']['key']
  bucket node['dotnet']['bucket']
  action :create
end

powershell "run update" do
  code <<-EOH
   #{node['dotnet']['update']['path']} /passive
  EOH
  action :run
end
