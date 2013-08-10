powershell "join domain" do
  code <<-EOH
  $ServerNamePS=#{node['server']['name']}
  $UserPS=#{node['domain']['username']}
  $PassPS= ConvertTo-SecureString "#{node['domain']['password']}" -AsPlainText -Force
  $DomainCred = New-Object System.Management.Automation.PSCredential $UserPS, $PassPS
  $DomainPS="#{node['domain']}"
  echo "Joining server $ServerNamePS to domain $DomainPS with user $UserPS"
  Add-Computer -DomainName $DomainPS -Credential $DomainCred -Restart -Force
  EOH
end
