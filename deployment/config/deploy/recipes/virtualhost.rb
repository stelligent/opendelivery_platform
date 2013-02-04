namespace :virtualhost do
  task :config do
    config_content = from_template("config/templates/virtualhost.erb")
    put config_content, "/home/ec2-user/virtualhost.conf"
    run "sudo mv /home/ec2-user/virtualhost.conf /etc/httpd/conf.d/virtualhost.conf"
  end
end
