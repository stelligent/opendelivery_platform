require 'rubygems'
require 'aws-sdk'
load 'aws.config'

sdb = AWS::SimpleDB.new

set :stack, ENV['stack']
set :ssh_key, ENV['key']

set :domain do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes["Domain"].values[0].to_s.chomp
end

set :artifact_bucket do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['ArtifactBucket'].values[0].to_s.chomp
end

set :ip_address do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['InstanceIPAddress'].values[0].to_s.chomp
end

set :private_ip_address do
  item = sdb.domains["stacks"].items["#{stack}"]
  item.attributes['PrivateIpAddress'].values[0].to_s.chomp
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
  
  task :wildtracks_config, :roles => :app do
    
    set :dataSource_url,              "jdbc:postgresql://localhost:5432/manatees_wildtrack"
    set :dataSource_username,         "manatee_user"
    set :dataSource_password,         "manatee1234"
    set :dataStorage_workDir,         "/var/tmp/manatees_wildtracks_workdir"
    set :dataStorage_ftpUrl,          "ftp.wildtracks.org"
    set :dataStorage_ftpUsername,     "argos@wildtracks.org"
    set :dataStorage_ftpPassword,     "Argos123!"
    set :databaseBackup_script_file,  "/usr/share/tomcat6/.sarvatix/manatees/wildtracks/database_backups/script/db_backup.sh"
    
    config_content = from_template("config/templates/wildtracks-config.properties.erb")
    put config_content, "/home/ec2-user/wildtracks-config.properties"
    
    run "sudo mv /home/ec2-user/wildtracks-config.properties /usr/share/tomcat6/.sarvatix/manatees/wildtracks/wildtracks-config.properties"
    run "sudo chown -R tomcat:tomcat /usr/share/tomcat6/.sarvatix/manatees/wildtracks/wildtracks-config.properties"
    run "sudo chmod 777 /usr/share/tomcat6/.sarvatix/manatees/wildtracks/wildtracks-config.properties"
  end
  
  task :liquibase, :roles => :db do
    
    db_username         = fetch(:dataSource_username)
    db_password         = fetch(:dataSource_password)
    private_ip_address  = fetch(:private_ip_address)
    
    set :liquibase_jar, "/usr/share/tomcat6/.grails/1.3.7/projects/Build/plugins/liquibase-1.9.3.6/lib/liquibase-1.9.3.jar"
    set :postgres_jar, "/usr/share/tomcat6/.ivy2/cache/postgresql/postgresql/jars/postgresql-8.4-701.jdbc3.jar"
    
    system("cp -rf /usr/share/tomcat6/.jenkins/workspace/DeployManateeApplication/grails-app/migrations/* /usr/share/tomcat6/.jenkins/workspace/DeployManateeApplication/")
    
    system("java -jar #{liquibase_jar}\
              --classpath=#{postgres_jar}\
              --changeLogFile=changelog.xml\
              --username=#{db_username}\
              --password=#{db_password}\
              --url=jdbc:postgresql://#{private_ip_address}:5432/manatees_wildtrack\
            update")
  end
  
  task :httpd_conf, :roles => :app do
    
    config_content = from_template("config/templates/httpd.conf.erb")
    put config_content, "/home/ec2-user/httpd.conf"
    
    run "sudo mv /home/ec2-user/httpd.conf /etc/httpd/conf/httpd.conf"
  end
  
  
  after "deploy:setup", "deploy:wildtracks_config"
  after "deploy:wildtracks_config", "deploy:httpd_conf"
  after "deploy:httpd_conf", "deploy:deploy"
  after "deploy:deploy", "deploy:liquibase"
  after "deploy:deploy", "deploy:restart"
end

