repo = ARGV[0]
platform_file_names = ['/usr/share/tomcat6/.jenkins/jobs/AddUserToNotificationGroup/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/BuildDeployedAMI/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/BuildInfrastructureAMI/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/CommonStepDefinitionGemBuild/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/CreateLoadBalancer/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/CreateTargetEnvironment/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/CreateTestDatabase/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/DeployApplication/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/ExportProductionDatabase/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/GetSSLArn/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/InfrastructureBuild/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/ListStacks/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/ShowDeliveryPipelineConfiguration/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/StartDeliveryPipeline/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/TerminateTargetEnvironment/config.xml',
              '/usr/share/tomcat6/.jenkins/jobs/UpdateDeliveryPipelineConfiguration/config.xml']

app_file_names = ['/usr/share/tomcat6/.jenkins/jobs/ApplicationBuild/config.xml']

platform_file_names.each do |file_name|
  text = File.read(file_name)
  output_of_gsub = text.gsub("git@github.com:stelligent/continuous_delivery_open_platform.git", "git@github.com:stelligent/#{repo}_platform.git")
  File.open(file_name, "w") {|file| file.puts output_of_gsub}
end

app_file_names.each do |file_name|
  text = File.read(file_name)
  output_of_gsub = text.gsub("git@github.com:stelligent/continuous_delivery_open_platform.git", "git@github.com:stelligent/#{repo}.git")
  File.open(file_name, "w") {|file| file.puts output_of_gsub}
end