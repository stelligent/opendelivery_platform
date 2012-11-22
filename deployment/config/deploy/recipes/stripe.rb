namespace :stripe do
  task :initializer do
    config_content = from_template("config/templates/stripe.erb")
    put config_content, "#{deploy_to}/#{artifact_name}/config/initializers/stripe.rb"
  end
end