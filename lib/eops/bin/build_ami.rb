require_relative '../config/initialize'

workspace_dir = ARGV[0]
sdb_domain = ARGV[1]
application_name = ARGV[2]
stack_name = ARGV[3]
sns_topic = ARGV[4]
type = ARGV[5]

@domain = Domain.new
@storage = Storage.new
@stack = Stack.new
@instance = Instance.new

language = @domain.get_property(sdb_domain, "properties", "Language")
ami = @domain.get_property(sdb_domain, "ami", "infrastructure")
domain = @domain.get_property(sdb_domain, "properties", "ProductionDomain")
group = @domain.get_property(sdb_domain, "properties", "GROUP")
s3bucket = @domain.get_property(sdb_domain, "properties", "S3Bucket")
security_group_id = @domain.get_property(sdb_domain, "properties", "SGID")
security_group_name = @instance.find_sg_name(security_group_id)
ssh_key = "development"

@stack.create("#{workspace_dir}/infrastructure/target/production.template", stack_name, {
  "Group"             => group,
  "Type"              => type,
  "AMI"               => ami,
  "HostedZone"        => domain,
  "ApplicationName"   => stack_name,
  "KeyName"           => ssh_key,
  "SecurityGroupName" => security_group_name,
  "S3Bucket"          => s3bucket,
  "SNSTopic"          => sns_topic,
  "Language"          => language,
  "MinSize"           => "1",
  "MaxSize"           => "1",
  "InstanceType"      => "m1.medium",
  "SDBDomain"         => sdb_domain})

@domain.load(stack_name, sdb_domain, stack_name)
