# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distimo/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'httparty'
  spec.name          = "distimo"
  spec.version       = Distimo::VERSION
  spec.authors       = ["Yuri Barbashov"]
  spec.email         = ["lolcoltd@gmail.com"]
  spec.description   = %q{Distimo API wrapper gem}
  spec.summary       = %q{Distimo API wrapper gem}
  spec.homepage      = "https://github.com/playa/distimo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
