class Image

  def initialize
    @ec2 = AWS::EC2.new
    @sdb = AWS::SimpleDB.new
    @auto_scale = AWS::AutoScaling.new
  end

  def create(auto_scaling_group_name, image_name, sdb_domain, ami_type)
    image = @ec2.images.create(:instance_id => @auto_scale.groups[auto_scaling_group_name].auto_scaling_instances.first.id,
                              :name => image_name)

    sleep 10

    while image.state != :available
      sleep 10
      case image.state
      when :failed
        image.delete
        raise RuntimeError, 'Image Creation Failed'
      end
    end
    @domain = Domain.new
    @domain.set_property(sdb_domain, "ami", ami_type, image.id)
  end
end
