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
set :language, ENV['language']

set :ip_address do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['InstanceIPAddress'].values[0].to_s.chomp
end

set :s3_bucket do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['ArtifactBucket'].values[0].to_s.chomp
end

set :artifact_url do
  item = sdb.domains["stacks"].items["properties"]
  item.attributes['ArtifactUrl'].values[0].to_s.chomp
end

set :artifact do
  File.basename("#{artifact_url}")
end

set :user,             "ec2-user"
set :use_sudo,         false

case
when language == "rails"
  set :deploy_to, "/var/www"
  
  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
    File.basename(artifact, ".*")
  end
when language == "java"
  set :deploy_to, "/usr/share/tomcat6/webapps"
  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
  end
end

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
  run "cd #{deploy_to} && sudo rm -rf #{deploy_to}/#{artifact_name}"
  config_content = from_template("config/templates/s3_download.rb")
  put config_content, "/home/ec2-user/s3_download.rb"
  run "sudo chmod 655 /home/ec2-user/s3_download.rb"
end
  
task :deploy do
  run "sudo ruby /home/ec2-user/s3_download.rb --outputdirectory #{deploy_to}/ --bucket #{s3_bucket} --key #{artifact}"
  case 
  when language == "rails"
    run "cd #{deploy_to} && sudo tar -zxf #{artifact}"
  end
end

task :bundle_install do
  run "cd #{deploy_to}/#{artifact_name} && bundle install"
end

task :db_migrate do
  run "cd #{deploy_to}/#{artifact_name} && sudo rake db:migrate"
end

task :virtualhost do
  config_content = from_template("config/templates/virtualhost.erb")
  put config_content, "/home/ec2-user/virtualhost.conf"
  run "sudo mv /home/ec2-user/virtualhost.conf /etc/httpd/conf.d/"
end

task :restart, :roles => :app do
  case 
  when language == "rails"
    run "sudo service httpd restart"
  when language == "java"
    run "sudo service httpd restart"
    run "sudo service tomcat6 restart"
  end
end

task :start, :roles => :app do
  run "sudo service httpd start"
end

task :stop, :roles => :app do
  run "sudo service httpd stop"
end

case 
when language == "rails"
after "setup", "deploy", "bundle_install", "db_migrate", "virtualhost", "restart"
when language == "java"
after "setup", "deploy", "restart"
end
