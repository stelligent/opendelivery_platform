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
  
  item.attributes.each_value do |name, value|
    puts "Name of attribute: " + name + "Value: " + value
  end
end