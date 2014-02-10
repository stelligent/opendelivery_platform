require 'rubygems'
require 'aws-sdk'
require 'trollop'
require 'opendelivery'
require 'json'
opts = Trollop::options do
  opt :stackname, "Name of CloudFormation Stack", :type => String, :required => true
  opt :templatename, "CloudFormation template name", :type => String, :required => true
  opt :awsconfig, "AWS Config file location", :required => true, :type => String
  opt :paramsfile, "JSON file containing parameters for stack", :required => true, :type => String
  opt :region, "Region to launch new machine", :type => String
end
params = JSON.parse(IO.read(opts[:paramsfile]))

load File.expand_path(opts[:awsconfig])

if opts[:region]
  AWS.config(:region => opts[:region])
end

domain = OpenDelivery::Domain.new
stack = OpenDelivery::Stack.new

stack.create(opts[:stackname], opts[:templatename],  params)