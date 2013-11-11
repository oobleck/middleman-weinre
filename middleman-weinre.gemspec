# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
# require "middleman-packager/pkg-info"

Gem::Specification.new do |s|
  s.name        = 'middleman-weinre'
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Rhodes"]
  s.email       = ["spencer at spencer dash rhodes dot com"]
  s.homepage    = "http://github.com/oobleck/middleman-weinre"
  s.summary     = "Auto starts Weinre remote debugger and prvides a simple insert helper to inject the script tag."
  s.description = s.summary # Middleman::Packager::TAGLINE
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.0.0"])
end