case node['platform']
when "windows"

  node['opendelivery']['config'].each do |key, value|
    windows_batch "set environment variables" do
      code <<-EOH
        setx #{key} "#{value}" /m
      EOH
    end
  end

else

  node['opendelivery']['config'].each do |key, value|
    execute "set environment variables" do
      code <<-EOH
        echo "export #{key}=#{value}" >> /etc/sysconfig/tomcat6
      EOH
    end
  end
end
