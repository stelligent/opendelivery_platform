node['opendelivery']['gems'].each do |gem, gem_version|
  gem_package gem do
    version gem_version || nil
    action :install
  end
end
