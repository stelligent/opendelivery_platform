require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')


opts = Trollop::options do
  opt :clientUser, "Client SVN Username", :short => "c", :type => String
  opt :clientPassword, "Client SVN Password", :short => "p",  :type => String
  opt :elasticUser, "Elastic Operations Google SVN Username", :short => "e",  :type => String
  opt :elasticPassword, "Elastic Operations Password", :short => "z",  :type => String
end

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["properties"]
  item.attributes.set("client_user" => "#{opts[:clientUser]}")
  item.attributes.set("client_password" => "#{opts[:clientPassword]}")
  item.attributes.set("elastic_user"   =>  "#{opts[:elasticUser]}")
  item.attributes.set("elastic_password"   => "#{opts[:elasticPassword]}")
end