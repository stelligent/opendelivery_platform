#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'

load File.expand_path('/opt/aws/aws.config')

class Email

  def add_email (email, topic)
    sns = AWS::SNS.new
    topic = sns.topics["#{topic}"]
    topic.subscribe("#{email}")
    puts "Success"
  end
  
end

# Mock subscribe and see what happens, capture how to handle the exception
# Pass in an email object rather than a string


# What are the ruby webservice tool kits

# Convert scripts into OO


def create_email (email_str)
  begin
    email = Email.new(email_str) # Might give conig options
  rescue
  end
end