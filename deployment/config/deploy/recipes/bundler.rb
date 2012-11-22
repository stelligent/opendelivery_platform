namespace :bundler do
  task :install do
    run "cd #{deploy_to}/#{artifact_name} && bundle install"
  end
end
