# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'myosx/version'

Gem::Specification.new do |spec|
  spec.name          = "myosx"
  spec.version       = Myosx::VERSION
  spec.authors       = ["Laura Martin"]
  spec.email         = ["surminus@gmail.com"]

  spec.summary       = %q{myosx configures OSX how I like it}
  spec.homepage      = "https://github.com/surminus/myosx."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["myosx"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
