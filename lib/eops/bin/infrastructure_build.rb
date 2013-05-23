require_relative "boot"

opts = Trollop::options do
  opt :key, "Key", :short => "k", :type => String
  opt :item, "SDB Item name", :short => "i", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

workspace_dir = ARGV[0]

system "cd #{workspace_dir}/infrastructure/puppet"
system "tar -czvf puppet.tar.gz modules/* manifests/*"
