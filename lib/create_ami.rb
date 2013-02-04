require_relative "boot"

opts = Trollop::options do
  opt :imagename, "Name of image", :short =>  "i", :type => String
  opt :autoscalingGroup, "Autoscaling Group", :short =>  "a", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
  opt :amitype, "Type of AMI to create", :short => "t", :type => String
end

ec2 = AWS::EC2.new
sdb = AWS::SimpleDB.new
auto_scale = AWS::AutoScaling.new

image = ec2.images.create(:instance_id => "#{auto_scale.groups["#{opts[:autoscalingGroup]}"].auto_scaling_instances.first.id}",
                          :name => "#{opts[:imagename]}")

sleep 10

while image.state != :available
  sleep 10
  case image.state
  when :failed
    image.delete
    raise RuntimeError, 'Image Creation Failed'
  end
end

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["ami"]

  item.attributes.set(
    "#{opts[:amitype]}" => "#{image.id}")
end
