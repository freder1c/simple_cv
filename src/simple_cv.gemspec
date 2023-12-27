# coding: utf-8

$LOAD_PATH.unshift(".")

require "lib/simple_cv/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_cv"
  spec.version       = SimpleCV::VERSION
  spec.authors       = ["Frederic Walch"]
  spec.email         = ["github@frederic.tech"]

  spec.summary       = %q{This Gem helps you to generate a awesome CV!}
  spec.homepage      = "https://github.com/freder1c"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prawn"
  spec.add_dependency "prawn-table"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
