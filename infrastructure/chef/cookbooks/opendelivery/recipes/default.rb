%w{ tomcat java }.each do |pkg|
  windows_package pkg do
    source node[pkg]['url']
    options node[pkg]['options']
    installer_type :custom
    action :install
  end

  path = Pathname.new(node[pkg]['home']) + '\\' + 'bin'

  windows_path path.to_s do
    action :add
  end
end


node['gems'].each do |gem, gem_version|
  gem_package gem do
    version gem_version || nil
    action :install
  end
end

node['path'].each do |var, path|
  windows_batch "set environment variables" do
    code <<-EOH
    setx #{var} "#{path}"
    EOH
  end
end
