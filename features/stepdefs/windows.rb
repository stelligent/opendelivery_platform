# require "PowerShellRunner.rb"

# remote_command = "dir"
# hostname = "localhost"
# username = "Administrator"
# password = "EVYA)SKxy?"

# psr = PowerShellRunner.new hostname, username, password, remote_command
# out, err = psr.execute
# puts out
# puts err


Given(/^a server set up at "(.*?)"$/) do |arg|
  @hostname = arg
end

Given(/^a user named "(.*?)"$/) do |arg|
  @username = arg
end

Given(/^a password of "(.*?)"$/) do |arg|
  @password = arg
end

When(/^I run "(.*?)"$/) do |remote_command|
  runner = PowerShellRunner.new @hostname, @username, @password, remote_command
  @std_out, @std_err = runner.execute
end

Then(/^I should see "(.*?)"$/) do |message|
  @std_out.include?(message).should_not == false
end
