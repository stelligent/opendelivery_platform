class KeyPair
  def initialize
    @ec2 = AWS::EC2.new
  end

  def create(name)
    key_pair = @ec2.key_pairs.create(name)
    File.open("/tmp/#{name}", "w") do |f|
      f.write(key_pair.private_key)
    end
  end

  def delete(name)
    @ec2.key_pairs[name].delete
  end
end
