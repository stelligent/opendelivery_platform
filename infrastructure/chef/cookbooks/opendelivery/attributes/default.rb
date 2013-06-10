default['tomcat']['url'] = 'https://s3.amazonaws.com/AdventTestBucket/apache-tomcat-7.0.40.exe'
default['tomcat']['home'] = 'C:\tomcat'
default['tomcat']['options'] = "/S /D=#{node['tomcat']['home']}"

default['java']['url'] = "https://s3.amazonaws.com/AdventTestBucket/jre-7u21-windows-i586-iftw.exe"
default['java']['home'] = 'C:\java\jre7'
default['java']['options'] = "/s INSTALLDIR=#{node['java']['home']}"
