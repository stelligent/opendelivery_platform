action :create do
  ensure_sshkey_gem_installed
  k = SSHKey.generate(:type => "RSA", :bits => 1024)

  ::File.open("#{Dir.home}/id_rsa", 'w') do |file|
    file.write(k.private_key)
  end

  ::File.open("#{Dir.home}/id_rsa.pub", 'w') do |file|
    file.write(k.ssh_public_key)
  end
end

private

def ensure_sshkey_gem_installed
  begin
    require 'sshkey'
  rescue LoadError
    Chef::Log.info("Missing gem 'sshkey'...installing now.")
    chef_gem "sshkey" do
      action :install
    end
    require 'sshkey'
  end
end
