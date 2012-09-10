Copyright (c) 2009 inimino@inimino.org, Marak Squires

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Steps for setup of CD Platform

1. Create a new S3 Bucket

2. Create a new RSA Keypair
 - ssh-keygen -t rsa -C "your@email.com"
 - ssh-add ~/.ssh/id_rsa

3. In S3 bucket created in Step #1, create folders { private, resources, gems }
4. Inside the resources folder create folders { aws_tools, rpm }
5. Upload select resources to buckets:

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

6. Run the account_bucket_policies.template with S3 Bucket from Step #1 as parameter
7. Run the security_group.template
8. Add port 5432 with source of security group to security group created in Step #7
9. Create development and production.pem
10. Create local aws.config file and store it in the config/aws/ folder
 - example: 
	AWS.config(
	  :access_key_id => "AKISAASVMCEFASMFUFRZMBQ",
	  :secret_access_key => "0EIfOsAl/0UqOaiJzE7emhecH/DSASDasdasds/SQ"
	)

11. Create SDB domain called "stacks"
 - ruby create_domain.rb --domain stacks