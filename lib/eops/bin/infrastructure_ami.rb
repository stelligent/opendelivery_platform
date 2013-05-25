require_relative '../config/initialize'

workspace_dir = ARGV[0]
sdb_domain = ARGV[1]
application_name = ARGV[2]

@domain = Domain.new
@storage = Storage.new

language = @domain.get_property(sdb_domain, "properties", "Language")
base_ami = @domain.get_property(sdb_domain, "ami", "base")
domain = @domain.get_property(sdb_domain, "properties", "ProductionDomain")
group = @domain.get_property(sdb_domain, "properties", "GROUP")
s3bucket = @domain.get_property(sdb_domain, "properties", "S3Bucket")
security_group_id = @domain.get_property(sdb_domain, "properties", "SGID")
security_group_name = @instance.find_sg_name(security_group_id)
