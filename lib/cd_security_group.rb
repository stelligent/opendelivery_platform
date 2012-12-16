require_relative "boot"

ec2 = AWS::EC2.new
sdb = AWS::SimpleDB.new

opts = Trollop::options do
  opt :securityGroupName, "Name of security group", :short => "s", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

security_group_name = ec2.security_groups.filter('group-name', "#{opts[:securityGroupName]}").first
security_group_id = security_group_name.id

security_group = ec2.security_groups["#{security_group_id}"]

security_group_owner = security_group.owner_id

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["properties"]
  item.attributes.delete('SGID')
  item.attributes.add('SGID' => "#{security_group_id}")
  item.attributes.delete('SGIDOwner')
  item.attributes.add('SGIDOwner' => "#{security_group_owner}")
end
