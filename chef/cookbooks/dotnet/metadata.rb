name "dotnet"
version "0.1.0"

%w{ powershell aws windows }.each do |cb|
  depends cb
end
