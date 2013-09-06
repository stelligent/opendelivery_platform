name "rabbitmq"
version "1.0.4"

%w{ amazon windows powershell }.each do |cb|
  depends cb
end
