namespace :configuration do
  task :application do
    config_content = from_template("config/templates/config.yml.erb")
    put config_content, "#{deploy_to}/#{artifact_name}/config/config.yml"
  end
end
