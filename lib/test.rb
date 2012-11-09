key_pair = ec2.key_pairs.create('test-key')
File.open("/home/mark/test-key.pem", 'w') do |file|
  file.write key_pair.private_key
end
