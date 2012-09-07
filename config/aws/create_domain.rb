require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('aws.config')

opts = Trollop::options do
  opt :domain, "Name of Domain", :short => "d", :type => String
end

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains.create("#{opts[:domain]}")
end