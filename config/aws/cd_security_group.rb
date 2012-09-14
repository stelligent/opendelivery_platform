require 'rubygems'
require 'aws-sdk'
require 'trollop'

load File.expand_path('aws.config')

ec2 = AWS::EC2.new

opts = Trollop::options do
  opt :securityGroupID, "ID of security group", :short => "s", :type => String
  opt :port, "Port to allow access to", :short => "p", :type => String
end

security_group = ec2.security_groups["#{opts[:securityGroupID]}"]
security_group.authorize_ingress(:tcp, "#{opts[:port]}", security_group)