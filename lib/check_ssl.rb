require_relative "boot"

iam = AWS::IAM.new
opts = Trollop::options do
  opt :name, "Name", :short => "n", :type => String
end

mycertificate = iam.server_certificates["#{opts[:name]}"]
puts mycertificate.arn
