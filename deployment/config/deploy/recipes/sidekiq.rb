namespace :sidekiq do
  set :sidekiq_cmd, "#{fetch(:bundle_cmd, "bundle")} exec sidekiq"

  task :start do
    rails_env = fetch(:rails_env, "production")
    run "cd #{deploy_to}/#{artifact_name}; nohup #{fetch(:sidekiq_cmd)} -e #{rails_env} >> #{deploy_to}/#{artifact_name}/log/sidekiq.log 2>&1 &", :pty => false
  end
end
