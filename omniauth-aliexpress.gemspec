# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/aliexpress/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-aliexpress"
  spec.version       = Omniauth::Aliexpress::VERSION
  spec.authors       = ["pinglamb"]
  spec.email         = ["pinglambs@gmail.com"]
  spec.summary       = %q{OmniAuth strategy for AliExpress}
  spec.description   = %q{OmniAuth strategy for AliExpress}
  spec.homepage      = "https://github.com/pinglamb/omniauth-aliexpress"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.1'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
