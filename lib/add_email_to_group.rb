require_relative "boot"

sns = AWS::SNS.new

opts = Trollop::options do
  opt :email, "Email Address", :short => "e", :type => String
  opt :snsarn, "Arn for AWS SNS topic", :short => "a", :type => String
end

topic = sns.topics["#{opts[:snsarn]}"]
topic.subscribe("#{opts[:email]}")
