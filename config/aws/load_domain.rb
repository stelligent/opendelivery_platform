require 'rubygems'
require 'aws-sdk'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')

opts = Trollop::options do
  opt :stackname, "Name of stack", :short => "n", :type => String
end

file = File.open("/tmp/properties", "r")

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["#{opts[:stackname]}"]
  
  file.each_line do|line|
    key,value = line.split '='
    item.attributes.set(
      "#{key}" => "#{value}")
  end
end