powershell "Rename Computer" do
  code <<-EOH
    $ServerNamePS="#{node['server']['name']}"
    Rename-Computer -NewName $ServerNamePS -Restart -Force
  EOH
end
