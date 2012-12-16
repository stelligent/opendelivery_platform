require_relative "boot"

opts = Trollop::options do
  opt :itemname, "Name of item", :short => "i", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

sdb = AWS::SimpleDB.new

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["#{opts[:itemname]}"]

  item.attributes.each_value do |name, value|
    puts "Name of attribute: #{name} | Value: #{value}"
  end
end
