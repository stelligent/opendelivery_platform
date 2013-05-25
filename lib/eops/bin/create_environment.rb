require_relative '../config/initialize'

workspace_dir = ARGV[0]
sdb_domain = ARGV[1]
stack_name = ARGV[2]
production = ARGV[3]
sns_topic  = ARGV[4]

@domain = Domain.new
@storage = Storage.new
@stack = Stack.new
@instance = Instance.new
@key_pair = KeyPair.new

if production
  ssh_key = "production"
  stage = "production"
  domain = @domain.get_property(sdb_domain, "properties", "ProductionDomain")
  min_size = @domain.get_property(sdb_domain, "properties", "ProductionAutoscalingGroupMinSize")
  max_size = @domain.get_property(sdb_domain, "properties", "ProductionAutoscalingGroupMaxSize")
  instance_type = @domain.get_property(sdb_domain, "properties", "InstanceType")

else

  @key_pair.create(stack_name)
  ssh_key = stack_name
  stage = "staging"

  domain = @domain.get_property(sdb_domain, "properties", "DevelopmentDomain")

  db_user = "transient"
  db_password = "transient"
  db_name = "eops"

  @domain.set_property(sdb_domain, stack_name, "DBUSER", db_user)
  @domain.set_property(sdb_domain, stack_name, "DBPASSWORD", db_password)
  @domain.set_property(sdb_domain, stack_name, "DBNAME", db_name)

  min_size = @domain.get_property(sdb_domain, "properties", "DevelopmentAutoscalingGroupMinSize")
  max_size = @domain.get_property(sdb_domain, "properties", "DevelopmentAutoscalingGroupMaxSize")
  instance_type = @domain.get_property(sdb_domain, "properties", "InstanceType")

end

language = @domain.get_property(sdb_domain, "properties", "Language")
ami = @domain.get_property(sdb_domain, "ami", "latest")
group = @domain.get_property(sdb_domain, "properties", "GROUP")
s3bucket = @domain.get_property(sdb_domain, "properties", "S3Bucket")
security_group_id = @domain.get_property(sdb_domain, "properties", "SGID")
security_group_name = @instance.find_sg_name(security_group_id)
security_group_owner_id = @domain.get_property(sdb_domain, "properties", "SGIDOwner")
type = "AMI"

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
  "MinSize"           => min_size,
  "MaxSize"           => max_size,
  "InstanceType"      => instance_type,
  "SDBDomain"         => sdb_domain})

@domain.load(stack_name, sdb_domain, stack_name)

if production

  db_user = "PRIVATE"
  db_password = "PRIVATE"
  db_endpoint = "PRIVATE"
else

  @stack.create("#{workspace_dir}/infrastructure/target/database.template", "#{stack_name}-DATABASE", {
      "SecurityGroupOwner" => security_group_owner_id,
      "SecurityGroup"      => security_group_id,
      "DBUser"             => db_user,
      "DBPassword"         => db_password,
      "DatabaseName"       => db_name})

  @domain.load("#{stack_name}-DATABASE", sdb_domain, stack_name)
  endpoint = @domain.get_property(sdb_domain, stack_name, "DatabaseEndpoint")
end
