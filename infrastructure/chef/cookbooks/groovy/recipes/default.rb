remote_file "/tmp/groovy-1.8.2.tar.gz" do
  source "https://s3.amazonaws.com/sea2shore/resources/binaries/groovy-1.8.2.tar.gz"
  mode "0644"
end

directory "/usr/bin/groovy-1.8.2/" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

execute "install-groovy" do
  command "tar -C /usr/bin/groovy-1.8.2/ -xvf /tmp/groovy-1.8.2.tar.gz"
end
