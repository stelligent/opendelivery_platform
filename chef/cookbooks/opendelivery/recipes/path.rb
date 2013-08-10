node['opendelivery']['config'].each do |var, path|
  windows_batch "set environment variables" do
    code <<-EOH
    setx #{var} "#{path}" /m
    EOH
  end
end
