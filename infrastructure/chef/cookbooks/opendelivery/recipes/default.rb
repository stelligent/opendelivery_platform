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


%w{ bundler aws-sdk cucumber net-ssh capistrano route53 rspec trollop rake }.each do |gem|
  gem_package gem do
    if gem == 'common-step-definitions'
      source node['common-step-definitions']['source']
    end
    version node[gem]['version'] || nil
    action :install
  end
end
