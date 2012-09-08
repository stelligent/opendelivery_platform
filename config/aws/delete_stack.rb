require 'rubygems'
require 'aws-sdk'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
end

cfn = AWS::CloudFormation.new
stack = cfn.stacks["#{opts[:stackname]}"]
stack.delete

while stack.exists?
  sleep 1
end
