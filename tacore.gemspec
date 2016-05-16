Gem::Specification.new do |s|
  s.name        = 'TACore'
  s.version     = '3.2.0'
  s.date        = '2016-05-16'
  s.summary     = "ThinAer Core API"
  s.description = "This allows access to the TA Core API"
  s.authors     = ["Greg Winn"]
  s.email       = 'greg.winn@thinaer.io'
  s.files       = ["lib/tacore.rb", "lib/exceptions.rb"]
  s.homepage    = 'http://thinaer.io'
  s.license     = 'None'
  s.add_dependency("oauth2", "~>1.1.0")
  s.add_development_dependency "rspec"
end
