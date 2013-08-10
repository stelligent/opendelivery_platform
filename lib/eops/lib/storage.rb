class Storage

  def initialize
    @s3 = AWS::S3.new
  end

  def copy(bucket, key, desired_key)
    @s3.buckets[bucket].objects[key].copy_to(desired_key)
  end

  def upload(file, bucket, key)
    @s3.buckets[bucket].objects[key].write(:file => file)
  end

  def download(bucket, key, output_directory)
    obj = @s3.buckets[bucket].objects[key]

    base = Pathname.new("#{obj.key}").basename

    Dir.mkdir(output_directory) unless File.exists?(output_directory)

    File.open("#{output_directory}/#{base}", 'w') do |file|
      file.write(obj.read)
    end
  end
end
