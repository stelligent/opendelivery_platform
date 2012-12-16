require_relative "boot"

ec2 = AWS::EC2.new
s3 = AWS::S3.new

opts = Trollop::options do
  opt :stackname, "Stack Name", :short => "n", :type => String
end

if ec2.key_pairs["#{opts[:stackname]}"].exists?
  ec2.key_pairs["#{opts[:stackname]}"].delete
end

key_pair = ec2.key_pairs.create("#{opts[:stackname]}")
File.open("/tmp/#{opts[:stackname]}.pem", "w") do |f|
  f.write(key_pair.private_key)
end
