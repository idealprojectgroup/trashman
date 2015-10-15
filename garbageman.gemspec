$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'garbage_man/version_number'

Gem::Specification.new do |s|
  s.name          = 'garbageman'
  s.version       = GarbageMan.version
  s.platform      = Gem::Platform::RUBY
  s.date          = '2015-10-15'
  s.summary       = "removes outdated periodic backup files from your cloud storage bucket"
  s.description   = s.summary
  s.authors       = ["Derek Hopper"]
  s.email         = 'hopper.derek@gmail.com'
  s.homepage      = 'http://github.com/idealprojectgroup/garbageman'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_rubygems_version = '>= 1.3.6'
  s.required_ruby_version = '>= 1.9'

  s.add_dependency('thor', '~> 0.19.1')
  s.add_dependency('fog', '~> 1.34.0')
end
