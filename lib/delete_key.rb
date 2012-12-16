require_relative "boot"

ec2 = AWS::EC2.new

opts = Trollop::options do
  opt :stackname, "Stack Name", :short => "n", :type => String
end

ec2.key_pairs["#{opts[:stackname]}"].delete
