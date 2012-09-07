# commented due to bug https://issues.griddynamics.net/browse/CFORD-229
# sudo pakage usually installed in base image
#package "sudo" do
#  action :install
#end

template "/etc/sudoers" do
  mode 0440
  owner "root"
  group "root"
  source "sudoers.erb"
  variables(
    :sudoers_groups => (node[:sudo_groups] ? node[:sudo_groups].keys : []),
    :sudoers_users  => (node[:sudo_users] ? node[:sudo_users].keys : [])
  )
end

