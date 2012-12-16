require_relative "boot"

opts = Trollop::options do
  opt :filename, "Name of file", :short => "n", :type => String
  opt :bucket, "Name of S3 bucket", :short => "b", :type => String
  opt :key, "Designated place to store file", :short => "k", :type => String
end

s3 = AWS::S3.new

file = "#{opts[:filename]}"
bucket_name = "#{opts[:bucket]}"
key = "#{opts[:key]}"

s3.buckets[bucket_name].objects[key].write(:file => file)
