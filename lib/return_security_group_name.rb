require_relative "boot"

ec2 = AWS::EC2.new

opts = Trollop::options do
  opt :securityGroupId, "Security Group ID", :short => "s", :type => String
end

puts ec2.security_groups["#{opts[:securityGroupId]}"].name
