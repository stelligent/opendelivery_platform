require 'trollop'

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
  opt :template_location, "path to CloudFormation Template", :short => "l",  :type => String
  opt :application, "Name of application", :short => "a",  :type => String
  opt :jenkins_internal_ip, "Jenkins internal IP", :short => "j",  :type => String
  opt :ssh_key, "SSH Key used in CloudFormation Template", :short => "k",  :type => String
  opt :securitygroup, "Name of security group used in CloudFormation Template", :short => "g",  :type => String
  opt :sns_topic, "Simple Notification Topic used in CloudFormation Template", :short => "s",  :type => String
end

puts "ApplicationName" + "#{opts[:stackname]}"