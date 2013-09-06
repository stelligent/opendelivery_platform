module S3FileLib
  def self.get_from_s3(bucket, key, path, aws_access_key, aws_secret_access_key)
    require 'aws-sdk'
    s3 = AWS::S3.new(
      :access_key_id => aws_access_key,
      :secret_access_key => aws_secret_access_key
    )

    obj = s3.buckets[bucket].objects[key]

    File.open(path, 'wb') do |file|
      obj.read do |chunk|
        file.write(chunk)
      end
    end
  end
end
