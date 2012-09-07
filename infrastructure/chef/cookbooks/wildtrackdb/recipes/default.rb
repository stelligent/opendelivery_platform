remote_file "/tmp/createDbAndOwner.sql" do
  source "https://s3.amazonaws.com/sea2shore/createDbAndOwner.sql"
  mode "0644"
end

remote_file "/tmp/wildtracks.sql" do
  source "https://s3.amazonaws.com/sea2shore/wildtracks.sql"
  mode "0644"
end

remote_file "/home/ec2-user/database_update.rb" do
  source "http://s3.amazonaws.com/sea2shore/database_update.rb"
  mode "0644"
end

execute "initdb" do
  command "service postgresql initdb"
end

template "/var/lib/pgsql/data/postgres.conf" do
  source "postgres.conf.erb"
  owner "postgres"
  group "postgres"
  mode "0600"
end

template "/var/lib/pgsql/data/pg_hba.conf" do
  source "pg_hba.erb"
  owner "postgres"
  group "postgres"
  mode "0600"
end

execute "startpsql" do
  command "service postgresql start"
end
