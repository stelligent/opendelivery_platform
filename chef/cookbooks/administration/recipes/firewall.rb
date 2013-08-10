powershell "Firewall state" do
  code <<-EOH
  netsh advfirewall set allprofiles state #{node['firewall']['state']}
  EOH
  action :run
end
