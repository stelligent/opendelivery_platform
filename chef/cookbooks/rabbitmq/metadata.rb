name "rabbitmq"
version "1.0.4"

%w{ aws windows powershell }.each do |cb|
  depends cb
end
