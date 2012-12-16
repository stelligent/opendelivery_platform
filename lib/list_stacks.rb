require_relative "boot"

cfn = AWS::CloudFormation.new

cfn.stacks.each do |stack|
  case stack.status
  when "CREATE_COMPLETE"
    puts "Stack Name: #{stack.name} | Status: Available"
  when "CREATE_IN_PROGRESS"
    puts "Stack Name: #{stack.name} | Status: In Progress"
  end
end
