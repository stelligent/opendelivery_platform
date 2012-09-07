require 'rubygems'
require 'aws-sdk'
load File.expand_path('../../config/aws.config', __FILE__)

opts = Trollop::options do
  opt :domain, "Name of Domain", :short => "d", :type => String
end

sdb = AWS::SimpleDB.new

domain = sdb.domains["stacks"]
domain.items["#{opts[:domain]}"].delete
