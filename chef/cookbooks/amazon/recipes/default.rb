chef_gem "aws-sdk" do
  action :install
  version node['amazon']['gem']['version']
end
