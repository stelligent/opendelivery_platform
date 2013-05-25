require_relative '../config/initialize'

workspace_dir = ARGV[0]
sdb_domain = ARGV[1]
application_name = ARGV[2]

@domain = Domain.new
@storage = Storage.new

s3bucket = @domain.get_property(sdb_domain, "properties", "S3Bucket")

Dir.chdir("#{workspace_dir}/#{application_name}") do
  system "tar -czvf #{application_name}.tar.gz *"
end

@storage.upload("#{application_name}/#{application_name}.tar.gz", s3bucket, "#{application_name}.tar.gz")

@domain.set_property(sdb_domain, "properties", "ArtifactUrl", "https:://s3.amazonaws.com/#{s3bucket}/#{application_name}.tar.gz")


Dir.chdir("#{workspace_dir}") do
  system "tar -czvf capistrano.tar.gz deployment/*"
end

@storage.upload("capistrano.tar.gz", s3bucket, "capistrano.tar.gz")
