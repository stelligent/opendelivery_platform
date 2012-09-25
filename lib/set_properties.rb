require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :property, "Name of property", :short => "p", :type => String
  opt :value, "Value of property", :short => "v", :type => String
  opt :itemname, "SDB Item name", :short => "i", :type => String
end

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["#{opts[:itemname]}"]
  
  item.attributes.set(
    "#{opts[:property]}" => ["#{opts[:value]}"])
end