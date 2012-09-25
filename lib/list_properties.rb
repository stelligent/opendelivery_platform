require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :itemname, "Name of item", :short => "i", :type => String
end

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["#{opts[:itemname]}"]
  
  item.attributes.each do |attribute|
    puts "Name of attribute: " + attribute.name + "Value: " + attribute.value
  end
end