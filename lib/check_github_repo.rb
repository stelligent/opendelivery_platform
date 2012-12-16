require_relative "boot"
require 'github_api'

opts = Trollop::options do
  opt :user, "Github Username", :short => "u", :type => String
  opt :pass, "Github Password", :short => "p", :type => String
  opt :organization, "Github Organization", :short => "o", :type => String
  opt :repo, "Github Repo", :short => "r", :type => String
end
github = Github.new login: "#{opts[:user]}", password: "#{opts[:pass]}"

item = github.repos.list(:org => "#{opts[:organization]}")

repository = "false"

item.each do |item|
  if item.full_name == "#{opts[:organization]}/#{opts[:repo]}"
    repository = "true"
  end
end

puts repository
