require_relative "boot"

workspace_dir = ARGV[0]

Dir.chdir("#{workspace_dir}/infrastructure/puppet") do
  system "tar -czvf puppet.tar.gz modules/* manifests/*"
end
