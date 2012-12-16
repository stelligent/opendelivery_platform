require_relative "boot"

opts = Trollop::options do
  opt :stackname, "Stack Name", :short => "s", :type => String
end

cfn = AWS::CloudFormation.new
ec2 = AWS::EC2.new

stack = cfn.stacks["#{opts[:stackname]}"]

stack.resources.each do |resource|
  if resource.resource_type == "AWS::EC2::Instance"
    @instance = resource.physical_resource_id
  end
end

instance = ec2.instances["#{@instance}"]
instance.terminate
