require_relative "boot"
require 'github_api'

opts = Trollop::options do
  opt :user, "Github Username", :short => "u", :type => String
  opt :pass, "Github Password", :short => "p", :type => String
end

github = Github.new login: "#{opts[:user]}", password: "#{opts[:pass]}"

github.repos.forks.create 'stelligent', 'continuous_delivery_open_platform'
github.repos.forks.create 'stelligent', 'continuous_delivery_open_platform_jenkins_configuration'
