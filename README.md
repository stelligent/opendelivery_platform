1. Create platform s3 bucket

2. Create a RSA Keypair
 - ssh-keygen -t rsa

3. Create private, gems, resources folders in S3 bucket
4. inside resources create aws_tools, binaries, rpm folders
5. Create SDB domain called "stacks"


ssh-keygen -t rsa -C "your@email.com"
ssh-add -l
ssh-add ~/.ssh/id_rsa

6. Run the account policy template with platform bucket
7. Run the security group template
8. Add port 5432 with source of security group to security group (provide screenshots)
9. Create development and production.pem