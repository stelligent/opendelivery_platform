require "rubygems"

#-------------------------
# Local or remote testing
#-------------------------
# Run tests locally
Given /^I am testing the local environment$/ do
  self.run_cmd = RunCmdWrapper.new
end

# Run tests remotely using ssh
Given /^I am sshed into the \w*\s*environment$/ do
  run_cmd
end

#-------------------------
# Defining install Dir
#-------------------------
# Define where an application is installed
Given /^(\S*) is installed at "([^"]*)"$/ do |app, install_dir|
  application_install_dir[app] = install_dir
  run_cmd.run("cd #{application_install_dir[app]}")
end

# Change directories to application install directory
Given /^I am in (\S*) install directory$/ do |app|
  application_install_dir[app].should_not be_nil
  run_cmd.base_directory = application_install_dir[app]
end

#-------------------------
# Running external commands
#-------------------------
# Run a command
When /^I run "([^"]*)"$/ do |cmd|
  self.output_lines = run_cmd.run(cmd)
end

# Partial match on command output
Then /^I should see "(.*)"$/ do |value|
  output_lines.should include value
end

Then /^I should see regexp "(.*)"$/ do |value|
  output_lines.should match value
end

Then /^I should see:$/ do |table|
  diff_table table, output_lines.split.map {|x| [x]}, :ignore_extra => true
end

Then /^I should only see "([^"]*)"$/ do |value|
  output_lines.chomp.should == value
end

#-------------------------
# Java property files
#-------------------------
# Read Java properties file
When /^I read "([^"]*)" property file$/ do |propFile|
  self.output_lines = run_cmd.run("cat #{propFile}")
  self.parsed_properties = read_properties(output_lines)
end

# Check Java properties file value
Then /^"([^"]*)" property should equal "([^"]*)"$/ do |property, value|
  parsed_properties[property].should == value
end

And /^I parse the output into space\-separated name value pairs$/ do
  self.parsed_properties = read_space_separated_properties(output_lines)
end
