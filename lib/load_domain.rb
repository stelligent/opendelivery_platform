#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'
require 'trollop'
load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :itemname, "Name of stack", :short => "n", :type => String
  opt :filename, "Name of file", :short => "f", :type => String
end

file = File.open("/tmp/#{opts[:filename]}", "r")

sdb = AWS::SimpleDB.new
  
AWS::SimpleDB.consistent_reads do
  domain = sdb.domains["stacks"]
  item = domain.items["#{opts[:itemname]}"]
  
  file.each_line do|line|
    key,value = line.split '='
    item.attributes.set(
      "#{key}" => "#{value}")
  end
end