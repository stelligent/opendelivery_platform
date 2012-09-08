require 'rubygems'
require 'aws-sdk'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')

opts = Trollop::options do
  opt :key, "Key", :short => "k", :type => String
  opt :item, "SDB Item name", :short => "i", :type => String
end

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["#{opts[:item]}"]
  
  item.attributes.each_value do |name, value|
    if name == "#{opts[:key]}"
      puts "#{value}".chomp
    end
  end
end