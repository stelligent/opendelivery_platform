require 'github_api'
require 'trollop'

opts = Trollop::options do
  opt :user, "Github Username", :short => "u", :type => String
  opt :pass, "Github Password", :short => "p", :type => String
end

Github.new login: "#{opts[:user]}", password: "#{opts[:pass]}"
keys = Github::Users::Keys.new

file = File.open("/tmp/id_rsa.pub", "r")
rsa = file.read

keys.create "title" => "CDPlatform",
             "key" => "#{rsa}"
