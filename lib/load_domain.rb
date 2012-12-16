require_relative "boot"

opts = Trollop::options do
  opt :itemname, "Name of stack", :short => "n", :type => String
  opt :filename, "Name of file", :short => "f", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

file = File.open("/tmp/#{opts[:filename]}", "r")

sdb = AWS::SimpleDB.new

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["#{opts[:sdbdomain]}"]
  item = domain.items["#{opts[:itemname]}"]

  file.each_line do|line|
    key,value = line.split '='
    item.attributes.set(
      "#{key}" => "#{value}")
  end
end
