namespace :database do
  task :config do
    config_content = from_template("config/templates/database.yml.erb")
    put config_content, "#{deploy_to}/#{artifact_name}/config/database.yml"
  end

  task :migration do
    run "cd #{deploy_to}/#{artifact_name} && rake db:migrate RAILS_ENV=#{stage}"
  end
end
