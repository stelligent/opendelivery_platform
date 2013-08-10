require 'aws-sdk'
require 'socket' 

Given(/^all required information is available$/) do
  @debug = false

  @user = ENV["username"]
  @user.should_not be_nil

  @pass = ENV["password"]
  @pass.should_not be_nil

  @host = ENV["hostname"]
  @host.should_not be_nil
end

Given(/^I can connect to the server$/) do
  # 3389 is RDP, should be open on all the windows boxes.
  hostname = "#{@host}.citest.cloud.advent"
  s = TCPSocket.open(hostname, 3389)
end

When(/^I run "(.*?)"$/) do |remote_command|
  runner = PowerShellRunner.new @host, @user, @pass, remote_command
  @std_out, @std_err = runner.execute
end

Then(/^I should see "(.*?)"$/) do |message|
  # spit out the stdout and stderr that came back, enable for troubleshooting
  if @debug
    puts "==================="
    puts @std_out
    puts "==================="
    puts @std_err
    puts "==================="
  end
  @std_out.include?(message).should_not == false
end

Then(/^I should see the error "(.*?)"$/) do |message|
  # spit out the stdout and stderr that came back, enable for troubleshooting
  if @debug
    puts "==================="
    puts @std_out
    puts "==================="
    puts @std_err
    puts "==================="
  end
  @std_err.include?(message).should_not == false
end

When(/^I retrieve the security groups for instance "(.*?)"$/) do |arg1|
  ec2 = AWS::EC2.new
  @instance = ec2.instances[arg1]
  @sgs = @instance.security_groups
end

Then(/^I should receive "(.*?)"$/) do |arg1|
  found = false
  @sgs.each do |group|
    if group.security_group_id == arg1
      found = true
    end
  end
  found.should == true
end

When (/^I inspect the servers$/) do
  cf = AWS::CloudFormation.new
  as = AWS::AutoScaling.new

  web = cf.stacks[@host]
  web.resources.each do |resource|
    if resource.resource_type == "AWS::AutoScaling::AutoScalingGroup"
      asg = as.groups[resource.physical_resource_id]
      @instances = asg.ec2_instances
    end
  end
end

Then /^each server should be using the following security groups$/ do |expected_groups|
  @instances.each do |instance|
    actual_groups = []
    instance.security_groups.each { |group| actual_groups << [group.id] }
    expected_groups.diff! actual_groups
  end
end

Then (/^each server should have "(.*?)" EBS volume\(s\)$/) do |arg1|
    @instances.each do |instance|
      instance.attachments.size.should == arg1.to_i
    end
end

  
