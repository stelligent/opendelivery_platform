require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
end

cfn = AWS::CloudFormation.new
stack = cfn.stacks["#{opts[:stackname]}"]
stack.delete

while stack.exists?
  sleep 1
end
