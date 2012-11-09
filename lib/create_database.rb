#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
  opt :securityGroupOwner, "Security Owner", :short => "o", :type => String
  opt :securityGroup, "Security Group", :short => "s",  :type => String
  opt :dbUser, "Database Username", :short => "u",  :type => String
  opt :dbPassword, "Database Password", :short => "p",  :type => String
end

file = File.open("#{opts[:templatelocation]}", "r")
template = file.read

cfn = AWS::CloudFormation.new
stack = cfn.stacks.create(
        "#{opts[:stackname]}", 
        template,
        :parameters => {
          "SecurityGroupOwner" => "#{opts[:securityGroupOwner]}",
          "SecurityGroup" => "#{opts[:securityGroup]}",
          "DBUser" => "#{opts[:dbUser]}",
          "DBPassword" => "#{opts[:dbPassword]}"
        },
        :capabilities => ["CAPABILITY_IAM"]
        )
        
while stack.status != "CREATE_COMPLETE"
  sleep 30
  
  case stack.status
  when "ROLLBACK_IN_PROGESS"
    stack.delete
  when "ROLLBACK_COMPLETE"
    stack.delete
  end
end

stack = cfn.stacks["#{opts[:stackname]}"]
File.open("/tmp/#{opts[:stackname]}", "w") do |aFile|
   stack.outputs.each do |output|
     cfnOutput = output.key + "=" + output.value + "\n"
     aFile.syswrite(cfnOutput) 
   end
end