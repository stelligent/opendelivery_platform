require_relative "boot"

auto_scaling = AWS::AutoScaling.new
ec2 = AWS::EC2.new

opts = Trollop::options do
  opt :autoscalingGroup, "Autoscaling Group", :short => "a", :type => String
end

auto_scaling_group = auto_scaling.groups["#{opts[:autoscalingGroup]}"].auto_scaling_instances.first.id

puts ec2.instances[auto_scaling_group].ip_address
