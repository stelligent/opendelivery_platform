require_relative '../config/initialize'

workspace_dir = ARGV[0]
sdb_domain = ARGV[1]
application_name = ARGV[2]

@domain = Domain.new
@storage = Storage.new

s3bucket = @domain.get_property(sdb_domain, "properties", "S3Bucket")


Dir.chdir("#{workspace_dir}/infrastructure/puppet") do
  system "tar -czvf puppet.tar.gz modules/* manifests/*"
end

@storage.upload("infrastructure/puppet/puppet.tar.gz", s3bucket, "puppet.tar.gz")

@domain.set_property(sdb_domain, "properties", "ArtifactUrl", "https:://s3.amazonaws.com/#{s3bucket}/#{application_name}.tar.gz")
