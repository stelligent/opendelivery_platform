#!/bin/bash -v

# Edit these values for your subversion repository
svn_user=`ruby /usr/share/tomcat6/scripts/aws/showback_domain.rb properties google_svn_user`
svn_password=`ruby /usr/share/tomcat6/scripts/aws/showback_domain.rb properties google_svn_pass`
  
cd /usr/share/tomcat6/.jenkins

# Move non versionable files back to .bak
mv hudson.scm.SubversionSCM.xml hudson.scm.SubversionSCM.xml.bak
mv hudson.plugins.s3.S3BucketPublisher.xml hudson.plugins.s3.S3BucketPublisher.xml.bak

svn add -q --parents *.xml jobs/*/config.xml users/*/config.xml userContent/

# Move non versionable files back 
mv hudson.scm.SubversionSCM.xml.bak hudson.scm.SubversionSCM.xml
mv hudson.plugins.s3.S3BucketPublisher.xml.bak hudson.plugins.s3.S3BucketPublisher.xml

# Remove config that no longer exists
svn status | grep '^!' | awk '{print $2;}' | xargs -r svn rm

svn ci --non-interactive --username $svn_user --password $svn_password -m 'automated commit of Jenkins configuration'