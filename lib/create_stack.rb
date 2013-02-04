require_relative "boot"

opts = Trollop::options do
  opt :stackname,         "Name of stack",                                             :short => "n", :type => String
  opt :templatelocation,  "Path to CloudFormation Template",                           :short => "l", :type => String
  opt :domain,            "Route 53 Domain",                                           :short => "d", :type => String
  opt :application,       "Name of application",                                       :short => "a", :type => String
  opt :sshkey,            "SSH Key used in CloudFormation Template",                   :short => "k", :type => String
  opt :securitygroup,     "Name of security group used in CloudFormation Template",    :short => "g", :type => String
  opt :snstopic,          "Simple Notification Topic used in CloudFormation Template", :short => "s", :type => String
  opt :s3bucket,          "S3 Bucket",                                                 :short => "b", :type => String
  opt :type,              "Infrastructure, Deployment or AMI",                         :short => "m", :type => String
  opt :ami,               "AMI to use",                                                :short => "i", :type => String
  opt :group,             "AMI to use",                                                :short => "t", :type => String
  opt :language,          "Language of application",                                   :short => "u", :type => String
  opt :minsize,           "Mininumum Size of Autoscaling group",                       :short => "q", :type => String
  opt :maxsize,           "Maximum Size of Autoscaling group",                         :short => "z", :type => String
  opt :instancesize,      "Size of Instance to use",                                   :short => "w", :type => String
  opt :sdbdomain,         "SimpleDb Domain for configuration",                         :short => "e", :type => String
end

StackBuilder.build(opts[:templatelocation], opts[:stackname],
                   "Group"             => opts[:group],
                   "Type"              => opts[:type],
                   "AMI"               => opts[:ami],
                   "HostedZone"        => opts[:domain],
                   "ApplicationName"   => opts[:application],
                   "KeyName"           => opts[:sshkey],
                   "SecurityGroupName" => opts[:securitygroup],
                   "S3Bucket"          => opts[:s3bucket],
                   "SNSTopic"          => opts[:snstopic],
                   "Language"          => opts[:language],
                   "MinSize"           => opts[:minsize],
                   "MaxSize"           => opts[:maxsize],
                   "InstanceType"      => opts[:instancesize],
                   "SDBDomain"         => opts[:sdbdomain])
