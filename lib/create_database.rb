require_relative "boot"

opts = Trollop::options do
  opt :stackname,          "Name of stack",     :short => "n", :type => String
  opt :securityGroupOwner, "Security Owner",    :short => "o", :type => String
  opt :securityGroup,      "Security Group",    :short => "s", :type => String
  opt :dbUser,             "Database Username", :short => "u", :type => String
  opt :dbName,             "Database Name",     :short => "x", :type => String
  opt :dbPassword,         "Database Password", :short => "p", :type => String
  opt :templatelocation,   "Template Location", :short => "t", :type => String
end

StackBuilder.build(opts[:templatelocation], opts[:stackname],
                   "SecurityGroupOwner" => opts[:securityGroupOwner],
                   "SecurityGroup"      => opts[:securityGroup],
                   "DBUser"             => opts[:dbUser],
                   "DatabaseName"       => opts[:dbName],
                   "DBPassword"         => opts[:dbPassword])
