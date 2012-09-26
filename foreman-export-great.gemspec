# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foreman-export-great/version'

Gem::Specification.new do |gem|
  gem.name          = "foreman-export-great"
  gem.version       = Foreman::Export::Great::VERSION
  gem.authors       = ["John Axel Eriksson"]
  gem.email         = ["john@insane.se"]
  gem.description   = %q{Foreman Runit exporter with support for dependent services}
  gem.summary       = %q{Foreman Runit exporter with support for dependent services}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
