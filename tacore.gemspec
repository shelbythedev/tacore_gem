Gem::Specification.new do |s|
  s.name        = 'TACore'
<<<<<<< HEAD
  s.version     = '4.1.0'
  s.date        = '2016-12-20'
=======
  s.version     = '4.0.1'
  s.date        = '2016-12-02'
>>>>>>> master
  s.summary     = "ThinAer Core API for the THINaer Platform"
  s.description = "This allows access to the TA Core API"
  s.authors     = ["Greg Winn", "Brandon Criss", "Shelby Solomon"]
  s.email       = 'greg.winn@thinaer.io'
  s.files       = ["lib/tacore.rb", "lib/exceptions.rb", "lib/tacore/client.rb",
                  "lib/tacore/venue.rb", "lib/tacore/device.rb", "lib/tacore/gateway.rb",
                   "lib/tacore/webhook.rb", "lib/tacore/app.rb"]
  s.homepage    = 'http://thinaer.io'
  s.license     = 'MIT'
  s.add_runtime_dependency "rest-client", "~>2.0.0"
  s.add_development_dependency "rspec"
end
