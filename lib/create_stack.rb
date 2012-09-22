require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
  opt :templatelocation, "Path to CloudFormation Template", :short => "l",  :type => String
  opt :application, "Name of application", :short => "a",  :type => String
  opt :jenkinsinternalip, "Jenkins internal IP", :short => "j",  :type => String
  opt :sshkey, "SSH Key used in CloudFormation Template", :short => "k",  :type => String
  opt :securitygroup, "Name of security group used in CloudFormation Template", :short => "g",  :type => String
  opt :snstopic, "Simple Notification Topic used in CloudFormation Template", :short => "s",  :type => String
end

file = File.open("#{opts[:templatelocation]}", "r")
template = file.read

cfn = AWS::CloudFormation.new
stack = cfn.stacks.create(
        "#{opts[:stackname]}", 
        template,
        :parameters => {
          "ApplicationName" => "#{opts[:application]}",
          "JenkinsInternalIP" => "#{opts[:jenkinsinternalip]}",
          "KeyName" => "#{opts[:sshkey]}",
          "SGID" => "#{opts[:securitygroup]}",
          "SNSTopic" => "#{opts[:snstopic]}"
        },
        :capabilities => ["CAPABILITY_IAM"]
        )
        
while stack.status != "CREATE_COMPLETE"
  sleep 30
  
  case stack.status
  when "ROLLBACK_IN_PROGESS"
    stack.delete
  when "ROLLBACK_COMPLETE"
    stack.delete
  end
end

stack = cfn.stacks["#{opts[:stackname]}"]
File.open("/tmp/properties", "w") do |aFile|
   stack.outputs.each do |output|
     cfnOutput = output.key + "=" + output.value + "\n"
     aFile.syswrite(cfnOutput) 
   end
end