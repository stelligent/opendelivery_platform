default['tomcat']['s3']['bucket'] = node['aws']['s3']['bucket']
default['tomcat']['windows']['name'] = "Apache Tomcat 7"
default['tomcat']['windows']['home'] = 'C:\tomcat'
default['tomcat']['windows']['service'] = 'Tomcat7'
default['tomcat']['windows']['options'] = "/S /D=#{node['tomcat']['windows']['home']}"

default['tomcat']['windows']['file'] = 'apache-tomcat-7.0.40.exe'
default['tomcat']['windows']['key'] = "3rdParty/#{node['tomcat']['windows']['file']}"
default['tomcat']['windows']['path'] = "Z:\\#{node['tomcat']['windows']['file']}"
