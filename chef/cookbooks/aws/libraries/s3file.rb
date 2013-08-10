module S3FileLib
  def self.get_from_s3(bucket, key, path)
    require 'aws-sdk'
    s3 = AWS::S3.new

    obj = s3.buckets[bucket].objects[key]

    File.open(path, 'wb') do |file|
      obj.read do |chunk|
        file.write(chunk)
      end
    end
  end
end
