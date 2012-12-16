require_relative "boot"

ses = AWS::SimpleEmailService.new

opts = Trollop::options do
  opt :email, "User's Email", :short => "e", :type => String
  opt :stackname, "Stackname", :short => "n", :type => String
  opt :domain, "domain", :short => "d", :type => String
  opt :databaseEndpoint, "endpoint", :short => "x", :type => String
  opt :databaseUsername, "username", :short => "u", :type => String
  opt :databasePassword, "password", :short => "p", :type => String
  opt :ipaddress, "ipaddress", :short => "i", :type => String
  opt :sender, "sender", :short => "s", :type => String
end


ses.send_email(
  :subject => 'Your development environment has been created!',
  :from => "#{opts[:sender]}",
  :to => "#{opts[:email]}",
  :body_text => "Your new environment is ready. IP Address: #{opts[:ipaddress]}.

  CloudFormation Stack Name: #{opts[:stackname]}
  Route53 Domain: #{opts[:domain]}
  Application: #{opts[:stackname]}
  Full Domain: #{opts[:stackname]}.#{opts[:domain]}
  Database Endpoint: #{opts[:databaseEndpoint]}
  Database Username: #{opts[:databaseUsername]}
  Database Password: #{opts[:databasePassword]}
  Below is your private ssh key to access your environment. Create or edit a file named #{opts[:stackname]}.pem and paste the below key inside:
  \n" + File.read("/tmp/#{opts[:stackname]}.pem") +
  "\n
  To ssh into you new environment type: ssh -i #{opts[:stackname]}.pem ec2-user@#{opts[:ipaddress]}")
