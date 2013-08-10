
# Simple script to publish our chef roles so clients can use them
# Start from the "chef/roles" directory in the repository.
#  ruby ./publish-roles.rb C:\chef

if ARGV[0].nil?
  puts "using default"
  chefDir = "C:\\chef"
else
  puts "Using #{ARGV[0]}"
  chefDir = ARGV[0]
end

roleDir = Dir.getwd

puts "Publishing deployment roles"
puts "  roleDir #{roleDir}"
puts "  chefDir #{chefDir}"

Dir.chdir( "#{chefDir}" )
Dir.pwd


roles = [  "base_web.json", "base_app.json", "base_db.json", "atlas_websrvr.json", "atlas_appsrvr.json", "atlas_database.json", "gls.json", "base.json", "agent.json", "advent_direct.json", "rabbit.json", "jenkins.json" ]
error = 0
roles.each do |role|
  puts "Publishing: #{role}"
  result = `knife role from file  "#{roleDir}/#{role}"`
  if  $? != 0
    puts "#{role} failed"
    error = 1
  end 
end

if error != 0
  puts "Publish failed" 
  exit(1)
end
