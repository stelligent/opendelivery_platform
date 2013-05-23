require 'rubygems'
require 'aws-sdk'
require 'trollop'
require_relative "stack_builder"

load File.expand_path('/opt/aws/aws.config')
