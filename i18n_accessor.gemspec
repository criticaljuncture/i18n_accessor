# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_accessor/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n_accessor"
  spec.version       = I18nAccessor::VERSION
  spec.authors       = ["Peregrinator"]
  spec.email         = ["bob.burbach@gmail.com"]
  spec.summary       = "Makes keys in your I18N files accessible as methods."
  spec.description   = "see README"
  spec.homepage      = "http://github.com/criticaljuncture/i18n_accessor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 3.3.0"
  spec.add_development_dependency "active_hash", '~> 1.4.0'
end
