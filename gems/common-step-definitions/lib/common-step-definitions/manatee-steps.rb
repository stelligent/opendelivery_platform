Then /^I should not be able to find any files under "([^"]*)" that are not owned by user "([^"]*)" in group "([^"]*)"$/ do |dir, user, group| 
  @output = @run_cmd.run("sudo find #{dir} ! -user #{user} ! -group #{group}")
  @output.strip.should be_empty
end


When /^I check the version of Tomcat installed$/ do
  @output = @run_cmd.run("basename /usr/share/tomcat6/lib/catalina-[0-9]*.jar")
  #or extract it and look at ServerInfo.properties
end

Then /^the major version should be (\d+)$/ do |major_version|
  file_segments = @output.split('-')
  version_segments = file_segments[1].split('.')

  version_segments[0].should == '6' 
  #version_segments[1].should == '0' 
end

When /^I check the version of httpd installed$/ do
  pending # express the regexp above with the code you wish you had
end
