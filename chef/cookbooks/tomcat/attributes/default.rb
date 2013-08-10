default['tomcat']['s3']['bucket'] = node['aws']['s3']['bucket']

case node['platform_family']
when "windows"
  default['tomcat']['name'] = "Apache Tomcat 7"
  default['tomcat']['home'] = 'C:\tomcat'
  default['tomcat']['service'] = 'Tomcat7'
  default['tomcat']['options'] = "/S /D=#{node['tomcat']['home']}"

  default['tomcat']['file'] = 'apache-tomcat-7.0.40.exe'
  default['tomcat']['key'] = "3rdParty/#{node['tomcat']['file']}"
  default['tomcat']['path'] = "Z:\\#{node['tomcat']['file']}"
else
  default['tomcat']['service'] = 'tomcat7'
  default['tomcat']['pkg'] = "tomcat7"
  default['tomcat']['home'] = "/usr/share/tomcat7"
  default['tomcat']['user'] = "tomcat"
  default['tomcat']['group'] = "tomcat"
end
