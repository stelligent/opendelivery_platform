#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'
require 'trollop'

load File.expand_path('/opt/aws/aws.config')

ec2 = AWS::EC2.new
sdb = AWS::SimpleDB.new

opts = Trollop::options do
  opt :securityGroupName, "Name of security group", :short => "s", :type => String
  opt :port, "Port to allow access to", :short => "p", :type => String
end

security_group_name = ec2.security_groups.filter('group-name', "#{opts[:securityGroupName]}").first
security_group_id = security_group_name.id

security_group = ec2.security_groups["#{security_group_id}"]
security_group.authorize_ingress(:tcp, "#{opts[:port]}", security_group)

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["properties"]
  item.attributes.delete('SGID')
  item.attributes.add('SGID' => "#{security_group_id}")
end

puts security_group_id