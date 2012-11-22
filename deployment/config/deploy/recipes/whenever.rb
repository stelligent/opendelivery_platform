namespace :whenever do
  task :set do
    run "cd #{deploy_to}/#{artifact_name} && whenever --set environment=#{stage} -w"
  end
end