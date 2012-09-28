#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'
load File.expand_path('/opt/aws/aws.config')

cfn = AWS::CloudFormation.new
time = Time.new

# Loop through all stacks on account
cfn.stacks.each do |i|
  
  # Get current date and time
  t1 = Time.parse(time.getutc.to_s)
  # Get date and time CloudFormation stack was created at
  t2 = Time.parse(i.creation_time.to_s)
  
  # Find difference between current time and CloudFormation Stack creation time by 24 hour periods
  diff = (t1 - t2)/86400
  
  # Filter through Stacks for Target Instance stacks
  if i.description == "Target"
    i.parameters.each do |k,v|
      if k == "KeyName"
        if v == "development"
          if diff > 1
            # If the difference between current time and CloudFormation stack creation time is greater that 24 hours, delete the stack
            i.delete
          end
        end
      end
    end 
  end
end