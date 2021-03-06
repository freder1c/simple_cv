# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_cv/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_cv"
  spec.version       = SimpleCV::VERSION
  spec.authors       = ["Frederic Walch"]
  spec.email         = ["fredericwalch@me.com"]

  spec.summary       = %q{This Gem helps you to generate a awesome CV!}
  spec.homepage      = "https://github.com/freder1c"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prawn", "2.2.2"
  spec.add_dependency "prawn-svg", "0.27.1"
  spec.add_dependency "hashugar", "1.0.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
