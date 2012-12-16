require_relative "boot"
require 'github_api'

opts = Trollop::options do
  opt :user, "Github Username", :short => "u", :type => String
  opt :pass, "Github Password", :short => "p", :type => String
  opt :project, "Github Project", :short => "j", :type => String
  opt :organization, "Github Organization", :short => "o", :type => String
  opt :extension, "extension", :short => "e", :type => String
end

github = Github.new login: "#{opts[:user]}", password: "#{opts[:pass]}"

github.repos.create :name => "#{opts[:project]}#{opts[:extension]}", :org => "#{opts[:organization]}"
