# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validates_immutability/version"

Gem::Specification.new do |s|
  s.name        = "validates_immutability"
  s.version     = ValidatesImmutability::VERSION
  s.authors     = ["Austin Schneider"]
  s.email       = ["soccer022483@gmail.com"]
  s.homepage    = ""
  s.summary     = "Validations for making ActiveRecord objects immutable."
  s.description = "Validations for making ActiveRecord objects immutable."

  s.rubyforge_project = "validates_immutability"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "sqlite3", "~> 1.3.3"
  s.add_development_dependency "activerecord", "~> 3.1.0"

  s.add_dependency "activesupport", "~> 3.1.0"
end
