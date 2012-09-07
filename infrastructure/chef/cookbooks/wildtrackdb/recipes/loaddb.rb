execute "wait" do
  command "sleep 20"
end

execute "create-user" do
  command "echo CREATE USER root | psql -U postgres"
end

execute "create-db-owner" do
  command "psql < /tmp/createDbAndOwner.sql -U postgres"
end

execute "load-db" do
  command "psql -U manatee_user -d manatees_wildtrack -f /tmp/wildtracks.sql"
end
