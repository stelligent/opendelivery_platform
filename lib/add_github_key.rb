require_relative "boot"
require 'github_api'

opts = Trollop::options do
  opt :user, "Github Username", :short => "u", :type => String
  opt :pass, "Github Password", :short => "p", :type => String
  opt :publicKey, "path to public key", :short => "k", :type => String
end

Github.new login: "#{opts[:user]}", password: "#{opts[:pass]}"
keys = Github::Users::Keys.new

file = File.open("#{opts[:publicKey]}", "r")
rsa = file.read

keys.create "title" => "CDPlatform",
             "key" => "#{rsa}"
