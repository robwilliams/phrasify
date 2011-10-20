# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "phrasify/version"

Gem::Specification.new do |s|
  s.name        = "phrasify"
  s.version     = Phrasify::VERSION
  s.authors     = ["Robert Williams"]
  s.email       = ["rob@r-williams.com"]
  s.homepage    = ""
  s.summary     = %q{Match phrases in text and replace them}
  s.description = %q{Match phrases in text and replace them efficiently across thousands of different terms.}

  s.rubyforge_project = "phrasify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec', '~> 2.6.0')
  s.add_development_dependency('yard')
end
