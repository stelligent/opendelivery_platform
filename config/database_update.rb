#!/usr/bin/ruby
require 'rubygems'
require 'aws-sdk'
load File.expand_path('aws.config')

s3 = AWS::S3.new

puts `cd /usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/ && \
      pg_dump -h localhost -U manatee_user manatees_wildtrack > \
      /usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/wildtracks.sql`

# Upload a file.
key = "wildtracks.sql"
bucket_name = "sea2shore"
s3.buckets[bucket_name].objects[key].write(:file => '/usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/wildtracks.sql')
puts "Uploading file #{key} to bucket #{bucket_name}."