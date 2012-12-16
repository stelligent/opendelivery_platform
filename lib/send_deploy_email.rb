require_relative "boot"

ses = AWS::SimpleEmailService.new

opts = Trollop::options do
  opt :email, "User's Email", :short => "e", :type => String
  opt :ipaddress, "ipaddress", :short => "i", :type => String
  opt :sender, "sender", :short => "s", :type => String
end


ses.send_email(
  :subject => 'Your Deployment was successful!',
  :from => "#{opts[:sender]}",
  :to => "#{opts[:email]}",
  :body_text => "Your application has been deployed successfully. You can view it by going to http://#{opts[:ipaddress]}/")
