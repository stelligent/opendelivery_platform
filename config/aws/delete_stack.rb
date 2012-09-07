require 'rubygems'
require 'aws-sdk'
load File.expand_path('../../config/aws.config', __FILE__)

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
end

cfn = AWS::CloudFormation.new
stack = cfn.stacks["#{opts[:stackname]}"]
stack.delete

while stack.exists?
  sleep 1
end
