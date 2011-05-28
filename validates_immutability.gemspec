# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validates_immutability/version"

Gem::Specification.new do |s|
  s.name        = "validates_immutability"
  s.version     = ValidatesImmutability::VERSION
  s.authors     = ["Austin Schneider"]
  s.email       = ["soccer022483@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "validates_immutability"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_dependency "activemodel", "~> 3.0.0"
end
