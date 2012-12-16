require_relative "boot"

opts = Trollop::options do
  opt :property, "Name of property", :short => "p", :type => String
  opt :value, "Value of property", :short => "v", :type => String
  opt :itemname, "SDB Item name", :short => "i", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

sdb = AWS::SimpleDB.new

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["#{opts[:itemname]}"]

  item.attributes.set(
    "#{opts[:property]}" => ["#{opts[:value]}"])
end
