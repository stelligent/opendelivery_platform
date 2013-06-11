default['tomcat']['url'] = 'https://s3.amazonaws.com/AdventTestBucket/apache-tomcat-7.0.40.exe'
default['tomcat']['home'] = 'C:\tomcat'
default['tomcat']['options'] = "/S /D=#{node['tomcat']['home']}"

default['java']['url'] = "https://s3.amazonaws.com/AdventTestBucket/jre-7u21-windows-i586-iftw.exe"
default['java']['home'] = 'C:\java\jre7'
default['java']['options'] = "/s INSTALLDIR=#{node['java']['home']}"

default['bundler']['version'] = '1.1.4'
default['aws-sdk']['version'] = '1.5.6'
default['cucumber']['version'] = '1.2.1'
default['net-ssh']['version'] = '2.5.2'
default['capistrano']['version'] = '2.12.0'
default['route53']['version'] = '0.2.1'
default['rspec']['version'] = '2.10.0'
default['trollop']['version'] = '2.0'
default['rake']['version'] = '0.9.2.2'

default['common-step-definitions']['source'] = 'C:\Downloads\common-step-definitions-1.0.0.gem'
