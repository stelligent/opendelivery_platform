require 'rubygems'
require 'aws-sdk'
load File.expand_path('/opt/aws/aws.config')

sdb = AWS::SimpleDB.new

set :stack, ENV['stack']
set :ssh_key, ENV['key']
set :type, ENV['type']
set :language, ENV['language']
set :stage, ENV['stage']

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

case
when stage == "development"
  set :database_name do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['DBNAME'].values[0].to_s.chomp
  end

  set :database_username do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['DBUSER'].values[0].to_s.chomp
  end

  set :database_password do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['DBPASSWORD'].values[0].to_s.chomp
  end

  set :database_endpoint do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['DatabaseEndpoint'].values[0].to_s.chomp
  end

when stage == "production"
  set :database_name do
    item = sdb.domains["stacks"].items["properties"]
    item.attributes['ProductionDatabaseName'].values[0].to_s.chomp
  end

  set :database_username do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['ProductionDatabaseUsername'].values[0].to_s.chomp
  end

  set :database_password do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['ProductionDatabasePassword'].values[0].to_s.chomp
  end

  set :database_endpoint do
    item = sdb.domains["stacks"].items["#{stack}"]
    item.attributes['ProductionDatabaseIP'].values[0].to_s.chomp
  end
end

case
when language == "rails"
  set :deploy_to, "/var/www"

  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
    File.basename(artifact, ".*")
  end
  case
  when stage == "development"
    set :rails_env, "development"

    set :stripe_secret_key do
      item = sdb.domains["stacks"].items["properties"]
      item.attributes['DevelopmentStripeSecretKey'].values[0].to_s.chomp
    end

    set :stripe_public_key do
      item = sdb.domains["stacks"].items["properties"]
      item.attributes['DevelopmentStripePublicKey'].values[0].to_s.chomp
    end
  when stage == "production"
    set :rails_env, "production"
    set :stripe_secret_key do
      item = sdb.domains["stacks"].items["properties"]
      item.attributes['ProductionStripeSecretKey'].values[0].to_s.chomp
    end

    set :stripe_public_key do
      item = sdb.domains["stacks"].items["properties"]
      item.attributes['ProductionStripePublicKey'].values[0].to_s.chomp
    end
  end
when language == "java"
  set :deploy_to, "/usr/share/tomcat6/webapps"
  set :artifact_name do
    artifact = File.basename("#{artifact_url}", ".*")
  end
end

set :user,             "ec2-user"
set :use_sudo,         false
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