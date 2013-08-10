class Image

  def initialize
    @ec2 = AWS::EC2.new
    @sdb = AWS::SimpleDB.new
    @auto_scale = AWS::AutoScaling.new
  end

  def create(as_group_name, image_name, sdb_domain, type, key)
    domain = Domain.new
    image = @ec2.images.create(
      instance_id: @auto_scale.groups[as_group_name].auto_scaling_instances.first.id,
      name: image_name
    )

    sleep 10

    while image.state != :available
      sleep 10
      case image.state
      when :failed
        image.delete
        raise RuntimeError, 'Image Creation Failed'
      end
    end
    domain.set_property(sdb_domain, key, type, image.id)
  end
end
