require 'rubygems'
require 'aws-sdk'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')

sdb = AWS::SimpleDB.new
cfn = AWS::CloudFormation.new
  
AWS::SimpleDB.consistent_reads do
      
  domain = sdb.domains["stacks"]   
      
  domain.items.each do |item|
    stack = item.name
    stack = cfn.stacks["#{stack}"]
    
    unless stack.exists? == false
      case stack.status
      when "CREATE_COMPLETE"
        puts "Stack #{stack.name} Available"
      when "CREATE_IN_PROGRESS"
        puts "Stack #{stack.name} In Progress"
        sleep 1
      else
        domain.items["#{stack}"].delete
      end
    else
      domain.items["#{stack}"].delete
    end
  end
end