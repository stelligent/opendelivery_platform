require 'rubygems'
require 'aws-sdk'

load File.expand_path('/opt/aws/aws.config')

opts = Trollop::options do
  opt :filename, "Name of file", :short => "n", :type => String
  opt :bucket, "Name of S3 bucket", :short => "b", :type => String
end

s3 = AWS::S3.new

key = "#{opts[:filename]}"
bucket_name = "#{opts[:bucket]}"

s3.buckets[bucket_name].objects[key].write(:file => "/tmp/#{key}")
