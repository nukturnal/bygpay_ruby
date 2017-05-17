# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bygpay/version'

Gem::Specification.new do |spec|
  spec.name          = "bygpay"
  spec.version       = Bygpay::VERSION
  spec.authors       = ["Alfred Rowe"]
  spec.email         = ["alfred@encodevlabs.com"]

  spec.summary       = "Bygpay Payment Gateway Ruby SDK"
  spec.description   = "Ruby Wrapper to process payments via any installed Bygpay Payment Gateway"
  spec.homepage      = "http://bygpay.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "http", "~> 2.2", ">= 2.2.2"
end
