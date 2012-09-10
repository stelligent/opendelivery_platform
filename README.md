License
-------

See LICENSE file.

Steps for setup of CD Platform
-------
Step 1: Create a new S3 Bucket
Step 2: Create a new RSA Keypair
 - ssh-keygen -t rsa -C "your@email.com"
 - ssh-add ~/.ssh/id_rsa

Step 3: In S3 bucket created in Step #1, create keys { private, resources, gems }
Step 4: Inside the resources keys create keys { aws_tools, rpm }
Step 5: Upload select resources to buckets:

 - ROOT of S3 bucket
   - hudson.plugins.s3.S3BucketPublisher.xml
   - jenkins_backup.sh
   - pg_hba.conf
   - server.xml
   - database_update.rb

 - ROOT/resources/aws_tools/
   - cfn-cli.tar.gz
   - sns-cli.tar.gz

 - ROOT/resources/rpm
   - ruby-1.9.3p0-2.amzn1.x86_64.rpm

 - ROOT/gems/
   - common-step-definitions-1.0.0.gem

 - ROOT/private/
   - id_rsa
   - id_rsa.pub
   - known_hosts

Step 6: Run the account_bucket_policies.template with S3 Bucket from Step #1 as parameter
Step 7: Run the security_group.template
Step 8: Add port 5432 with source of security group to security group created in Step #7
Step 9: Create development and production.pem
Step 10: Create local aws.config file and store it in the config/aws/ folder
 - example: 
	AWS.config(
	  :access_key_id => "AKISAASVMCEFASMFUFRZMBQ",
	  :secret_access_key => "0EIfOsAl/0UqOaiJzE7emhecH/DSASDasdasds/SQ"
	)

Step 11: Create SDB domain called "stacks"
 - ruby create_domain.rb --domain stacks