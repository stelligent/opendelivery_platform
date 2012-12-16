require_relative "boot"

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
end

cfn = AWS::CloudFormation.new
stack = cfn.stacks["#{opts[:stackname]}"]
stack.delete

while stack.exists?
  sleep 30
end
