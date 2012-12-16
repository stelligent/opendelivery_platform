require_relative "boot"

opts = Trollop::options do
  opt :sdbdomain, "Name of sdb domain", :short => "q", :type => String
end

sdb = AWS::SimpleDB.new

AWS::SimpleDB.consistent_reads do
  domain = sdb.domains.create("#{opts[:sdbdomain]}")
end
