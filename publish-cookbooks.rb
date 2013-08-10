
# Simple script to publish our chef cookbooks so clients can use them
# Start from the "chef/cookbooks" directory in the repository.
#   ruby ./publish-cookbooks.rb C:\chef [cookbook]
# If you pass the name of a cookbook, it will only do that one.

if ARGV[0].nil?
  puts "using default"
  chefDir = "C:\\chef"
else
  puts "Using #{ARGV[0]}"
  chefDir = ARGV[0]
end


cookbooks = "atlas advent_direct administration dotnet rabbitmq sql_server aws tomcat-windows opendelivery visual_studio openssl java"
unless ARGV[1].nil?
  cookbooks = ARGV[1]
end

cookDir = Dir.getwd

puts "Publishing cookbooks [#{$cookbooks}]"
puts "  cookDir #{cookDir}"
puts "  chefDir #{chefDir}"

Dir.chdir( "#{chefDir}" )
Dir.pwd


result = `knife cookbook upload --cookbook-path "#{cookDir}" #{cookbooks}`

# TODO: This doesn't actually detect failure if you are missing a cookbook
if  $? != 0
  puts result
  puts "*** cookbook upload failed"
  exit(1)
end
puts result
