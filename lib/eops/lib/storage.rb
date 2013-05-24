require_relative "boot"

class Storage

  def initialize
    @s3 = AWS::S3.new
  end

  def upload(file, bucket, key)
    @s3.buckets[bucket_name].objects[key].write(:file => file)
  end

  def download(bucket, key, output_directory)
    obj = @s3.buckets["#{opts[:bucket]}"].objects["#{opts[:key]}"]

    base = Pathname.new("#{obj.key}").basename

    Dir.mkdir(output_directory) unless File.exists?(output_directory)

    File.open("#{output_directory}/#{base}", 'w') do |file|
      file.write(obj.read)
    end
  end
end
