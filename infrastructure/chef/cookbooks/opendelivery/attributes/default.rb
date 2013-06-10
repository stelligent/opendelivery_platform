default['tomcat']['url'] = 'http://apache.petsads.us/tomcat/tomcat-7/v7.0.40/bin/apache-tomcat-7.0.40.exe'
default['tomcat']['home'] = 'C:\tomcat'
default['tomcat']['options'] = '/D=C:\tomcat'


default['ruby']['url'] = "http://rubyforge.org/frs/download.php/76952/rubyinstaller-1.9.3-p429.exe"
default['ruby']['silent'] = "/silent"

default['java']['url'] = "http://javadl.sun.com/webapps/download/AutoDL?BundleId=76870"
default['java']['home'] = "C:\java\jre7"
default['java']['options'] = "/s INSTALLDIR=#{node['java']['home']}"
