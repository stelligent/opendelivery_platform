require 'rubygems'
require 'aws-sdk'
load File.expand_path('/opt/aws/aws.config')

sdb = AWS::SimpleDB.new

def get_binding
  binding # So that everything can be used in templates generated for the servers
end

def from_template(file)
  require 'erb'
  template = File.read(File.join(File.dirname(__FILE__), "..", file))
  result = ERB.new(template).result(self.get_binding)
end

set :stack, ENV['stack']
set :ssh_key, ENV['key']
set :type, ENV['type']

set :ip_address do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['InstanceIPAddress'].values[0].to_s.chomp
end

set :artifact_url do
  item = sdb.domains["stacks"].items["properties"]
  item.attributes['ArtifactUrl'].values[0].to_s.chomp
end

set :user,             "ec2-user"
set :use_sudo,         false
set :deploy_to,        "/usr/share/tomcat6/webapps"
set :ssh_options,      { :forward_agent => true, 
                         :paranoid => false, 
                         :keys => ssh_key }
                         
if type == "local"
  role :web, "localhost"
  role :app, "localhost"
  role :db,  "localhost", :primary => true
else
  role :web, ip_address
  role :app, ip_address
  role :db,  ip_address, :primary => true
end

set :deploy_via, :remote_cache

task :setup do
  run "sudo chown -R tomcat:tomcat #{deploy_to}"
  run "sudo service httpd stop"
  run "sudo service tomcat6 stop"
  run "sudo rm -rf #{deploy_to}/*"
end
  
task :deploy do
  run "cd #{deploy_to} && sudo wget #{artifact_url}"
end

task :restart, :roles => :app do
  run "sudo service httpd restart"
  run "sudo service tomcat6 restart"
end
  
after "setup", "deploy"
after "deploy", "restart"

