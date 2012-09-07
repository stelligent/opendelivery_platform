require 'rake'

Gem::Specification.new do |s|
  s.name        = 'common-step-definitions'
  s.version     = '1.0.0'
  s.summary     = "Support code and step definitions for Scripted Environments/Infrastructure!"
  s.description = s.summary
  s.authors     = ["Manatees"]
  s.email       = 'manatee@stelligent.com'
  s.files       = FileList["lib/*.rb","lib/common-step-definitions/*.rb"]
  s.add_dependency('net-ssh','2.3.0')
end
