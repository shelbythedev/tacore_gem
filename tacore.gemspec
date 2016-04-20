Gem::Specification.new do |s|
  s.name        = 'TACore'
  s.version     = '1.1.0'
  s.date        = '2016-04-20'
  s.summary     = "ThinAer Core API"
  s.description = "This allows access to the TA Core API"
  s.authors     = ["Greg Winn"]
  s.email       = 'greg.winn@thinaer.io'
  s.files       = ["lib/tacore.rb"]
  s.homepage    = 'http://thinaer.io'
  s.license     = 'None'
  s.add_dependency("rest-client", "~>1.8.0")
end
