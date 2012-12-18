require 'rubygems'
require 'aws-sdk'
load File.expand_path('/opt/aws/aws.config')

set :stack, ENV['stack']
set :ssh_key, ENV['key']
set :type, ENV['type']
set :language, ENV['language']
set :sdbdomain, ENV['sdbdomain']

def sdb
  @sdb ||= AWS::SimpleDB.new
end

def auto_scale
  @auto_scaling ||= AWS::AutoScaling.new
end

def sdb_var(item_key, attr_key)
  sdb.domains["#{sdbdomain}"].items[item_key].attributes[attr_key].values[0].to_s.chomp
end

def ec2
  @ec2 ||= AWS::EC2.new
end

set :user, "ec2-user"
set :use_sudo, false
set :ssh_options, { :forward_agent => true,
                    :paranoid => false,
                    :keys => ssh_key }

if type == "local"
  role :web, "localhost"
  role :app, "localhost"
  role :db, "localhost", :primary => true
else
  set :ip_address do
    first_instance_in_group = auto_scale.groups[sdb_var(stack, "AutoscalingGroup")].auto_scaling_instances.first.id
    ec2.instances[first_instance_in_group].ip_address
  end

  role :web, ip_address
  role :app, ip_address
  role :db, ip_address, :primary => true
end

set :s3_bucket, sdb_var("properties", "S3Bucket")
set :artifact_url, sdb_var("properties", "ArtifactUrl")

set :artifact do
  File.basename("#{artifact_url}")
end

task :staging do
  set :stage, "staging"
  set :rails_env, "staging"

  set :database_name, sdb_var(stack, "DBNAME")
  set :database_username, sdb_var(stack, "DBUSER")
  set :database_password, sdb_var(stack, "DBPASSWORD")
  set :database_endpoint, sdb_var(stack, "DatabaseEndpoint")
end

task :production do
  set :stage, "production"
  set :rails_env, "production"

  set :database_name, sdb_var("properties", "ProductionDatabaseName")
  set :database_username, sdb_var("properties", "ProductionDatabaseUsername")
  set :database_password, sdb_var("properties", "ProductionDatabasePassword")
  set :database_endpoint, sdb_var("properties", "ProductionDatabaseIP")
end

task :rails do
  set :deploy_to, "/var/www"

  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
    File.basename(artifact, ".*")
  end
end

task :java do
  set :deploy_to, "/usr/share/tomcat6/webapps"
  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
  end
end

set :deploy_via, :remote_cache
