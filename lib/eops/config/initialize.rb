require 'rubygems'
require 'aws-sdk'
require 'trollop'

load File.expand_path('/opt/aws/aws.config')

APP_PATH = File.expand_path('../../', __FILE__) + '/'

require APP_PATH + 'lib/database.rb'
require APP_PATH + 'lib/domain.rb'
require APP_PATH + 'lib/image.rb'
require APP_PATH + 'lib/instance.rb'
require APP_PATH + 'lib/key_pair.rb'
require APP_PATH + 'lib/stack.rb'
require APP_PATH + 'lib/storage.rb'
