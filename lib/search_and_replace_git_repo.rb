platform_file_names = ['/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/AddUserToNotificationGroup/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/BuildDeployedAMI/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/BuildInfrastructureAMI/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/CommonStepDefinitionGemBuild/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/CreateLoadBalancer/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/CreateTargetEnvironment/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/CreateTestDatabase/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/DeployApplication/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/ExportProductionDatabase/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/GetSSLArn/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/InfrastructureBuild/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/ListStacks/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/ShowDeliveryPipelineConfiguration/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/StartDeliveryPipeline/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/TerminateTargetEnvironment/config.xml',
              '/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/UpdateDeliveryPipelineConfiguration/config.xml']

app_file_names = ['/Users/brianjakovich/Development/OPENDELIVERY/continuous_delivery_open_platform_jenkins_configuration/jobs/ApplicationBuild/config.xml']

platform_file_names.each do |file_name|
  text = File.read(file_name)
  output_of_gsub = text.gsub("git@github.com:stelligent/continuous_delivery_open_platform.git", "git@github.com:stelligent/stelligent_platform.git")
  File.open(file_name, "w") {|file| file.puts output_of_gsub}
end

app_file_names.each do |file_name|
  text = File.read(file_name)
  output_of_gsub = text.gsub("git@github.com:stelligent/continuous_delivery_open_platform.git", "git@github.com:stelligent/stelligent.git")
  File.open(file_name, "w") {|file| file.puts output_of_gsub}
end