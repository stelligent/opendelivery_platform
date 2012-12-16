require_relative "boot"

opts = Trollop::options do
  opt :key, "Key", :short => "k", :type => String
  opt :item, "SDB Item name", :short => "i", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

sdb = AWS::SimpleDB.new

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["#{opts[:item]}"]

  item.attributes.each_value do |name, value|
    if name == "#{opts[:key]}"
      puts "#{value}".chomp
    end
  end
end
