template "/home/ec2-user/aws.config" do
  source "aws.config.erb"
  owner "ec2-user"
  group "ec2-user"
  mode "0500"
end

package "libxml2-devel" do
  action :install
end

package "libxslt-devel" do
  action :install
end

gem_package "bundler" do
  action :install
end

gem_package "aws-sdk" do
  action :install
end

remote_file "/tmp/id_rsa.pub" do
  source "https://s3.amazonaws.com/sea2shore/private/id_rsa.pub"
  owner "root"
  group "root"
end

execute "copy_to_authorized_keys" do
  command "cat /tmp/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys"
end
