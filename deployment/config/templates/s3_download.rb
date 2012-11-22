require 'rubygems'
require 'aws-sdk'
require 'trollop'
require 'pathname'

load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :outputdirectory, "Output directory", :short => "d", :type => String
  opt :bucket, "Name of S3 bucket", :short => "b", :type => String
  opt :key, "File in S3", :short => "k", :type => String
end

s3 = AWS::S3.new

obj = s3.buckets["#{opts[:bucket]}"].objects["#{opts[:key]}"]

base = Pathname.new("#{obj.key}").basename

Dir.mkdir("#{opts[:outputdirectory]}") unless File.exists?("#{opts[:outputdirectory]}")

File.open("#{opts[:outputdirectory]}/#{base}", 'w') do |file|
  file.write(obj.read)
end