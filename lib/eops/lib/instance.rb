class Instance
  def initialize
    @ec2 = AWS::EC2.new
    @auto_scaling= AWS::AutoScaling.new
  end

  def destroy
  end

  def find_in_as_group(as_group_name)
    first_instance = @auto_scaling.groups[as_group_name].auto_scaling_instances.first.id

    return @ec2.instances[first_instance].ip_address
  end
end
