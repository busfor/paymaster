# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paymaster/version'

Gem::Specification.new do |spec|
  spec.name          = "paymaster"
  spec.version       = Paymaster::VERSION
  spec.authors       = ["Kirill Platonov"]
  spec.email         = ["mail@kirillplatonov.com"]

  spec.summary       = "Ruby wrapper for Paymaster.ua API"
  spec.description   = "Ruby wrapper for Paymaster.ua API"
  spec.homepage      = "https://github.com/kirillplatonov/paymaster"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "builder"
  spec.add_dependency "activesupport", ">= 4.1.8"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
