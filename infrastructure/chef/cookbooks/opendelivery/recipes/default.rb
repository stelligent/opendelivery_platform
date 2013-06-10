%w{ tomcat java }.each do |pkg|
  windows_package pkg do
    source node[pkg]['url']
    options node[pkg]['options']
    installer_type :custom
    action :install
  end

  windows_path "#{node[pkg]['home']}\bin" do
    action :add
  end
end
