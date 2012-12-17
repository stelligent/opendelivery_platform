require_relative "boot"

opts = Trollop::options do
  opt :domain, "Name of Domain", :short => "d", :type => String
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

sdb = AWS::SimpleDB.new

domain = sdb.domains["#{opts[:sdbdomain]}"]
domain.items["#{opts[:domain]}"].delete
