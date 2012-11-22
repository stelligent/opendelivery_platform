def get_binding
  binding
end

def from_template(file)
  require 'erb'
  file = File.open(file, "rb")
  template = file.read
  result = ERB.new(template).result(self.get_binding)
end