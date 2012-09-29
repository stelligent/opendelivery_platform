require 'rubygems'
require 'aws-sdk'
require 'trollop'

load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :stackname, "Stack Name", :short => "s", :type => String
  opt :imagename, "Name of image", :short =>  "i", :type => String
end

cfn = AWS::CloudFormation.new
ec2 = AWS::EC2.new
sdb = AWS::SimpleDB.new

stack = cfn.stacks["#{opts[:stackname]}"]

stack.resources.each do |resource|
  if resource.resource_type == "AWS::EC2::Instance"
    @instance = resource.physical_resource_id
  end
end

image = ec2.images.create(:instance_id => "#{@instance}",
                  :name => "#{opts[:imagename]}")
                  
while image.state != :available
  sleep 10
  case image.state
  when "failed"
    image.delete
    raise RuntimeError, 'Image Creation Failed'
  end
end

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["ami"]
  
  item.attributes.set(
    "latest" => "#{image.id}")
end
