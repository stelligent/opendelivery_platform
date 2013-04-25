task :preconfigure do
  run "cd #{deploy_to} && sudo rm -rf #{deploy_to}/#{artifact_name}"
  run "cd #{deploy_to} && sudo mkdir #{artifact_name}"
  config_content = from_template("config/templates/s3_download.erb")
  put config_content, "/home/ec2-user/s3_download.rb"
  run "sudo chmod 655 /home/ec2-user/s3_download.rb"
end

task :update_code do
  run "sudo ruby /home/ec2-user/s3_download.rb --outputdirectory #{deploy_to}/#{artifact_name} --bucket #{s3_bucket} --key #{artifact}"
  run "cd #{deploy_to}/#{artifact_name} && sudo tar -zxf #{artifact}"
  run "sudo chown -R ec2-user:ec2-user #{deploy_to}/#{artifact_name}"
end

task :restart, :roles => :app do
  run "sudo service httpd restart"
end

task :postconfigure do
  run "cd #{deploy_to}/#{artifact_name} && sudo chown -R ec2-user:ec2-user ."
end

task :deploy do
  rails
  preconfigure
  update_code
  database.config
  bundler.install
  virtualhost.config
  postconfigure
  restart
end
