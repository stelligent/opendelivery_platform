require 'rubygems'
require 'aws-sdk'
load File.expand_path('/usr/share/tomcat6/scripts/config/aws.config')

sdb = AWS::SimpleDB.new

set :stack, ENV['stack']
set :ssh_key, ENV['key']

set :artifact_bucket do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['ArtifactBucket'].values[0].to_s.chomp
end

set :ip_address do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['InstanceIPAddress'].values[0].to_s.chomp
endm.attributes['PrivateIpAddress'].values[0].to_s.chomp
end

set :user,             "ec2-user"
set :use_sudo,         false
set :deploy_to,        "/usr/share/tomcat6/webapps"
set :artifact,         "wildtracks.war"
set :artifact_url,     "https://s3.amazonaws.com/#{artifact_bucket}/#{artifact}"
set :ssh_options,      { :forward_agent => true, :paranoid => false, :keys => ssh_key }

set :application, domain

role :web, ip_address
role :app, ip_address
role :db,  ip_address, :primary => true

set :deploy_via, :remote_cache

def get_binding
  binding # So that everything can be used in templates generated for the servers
end

def from_template(file)
  require 'erb'
  template = File.read(File.join(File.dirname(__FILE__), "..", file))
  result = ERB.new(template).result(self.get_binding)
end

namespace :deploy do
  
  task :setup do
    run "sudo chown -R tomcat:tomcat #{deploy_to}"
    run "sudo service httpd stop"
    run "sudo service tomcat6 stop"
  end
  
  task :deploy do
    run "cd #{deploy_to} && sudo rm -rf wildtracks* && sudo wget #{artifact_url}"
  end

  task :restart, :roles => :app do
    run "sudo service httpd restart"
    run "sudo service tomcat6 restart"
  end
  
  after "deploy:setup", "deploy:deploy"
  after "deploy:deploy", "deploy:restart"
end

