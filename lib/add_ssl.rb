require_relative "boot"

iam = AWS::IAM.new
certificates = iam.server_certificates


opts = Trollop::options do
  opt :name, "Name", :short => "n", :type => String
end

certificates.upload(:name => "#{opts[:name]}",
                    :certificate_body => "",
                    :private_key => "")
