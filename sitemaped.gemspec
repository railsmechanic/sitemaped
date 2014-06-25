# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sitemaped/version'

Gem::Specification.new do |spec|
  spec.name          = "sitemaped"
  spec.version       = Sitemaped::VERSION
  spec.authors       = ["Matthias Kalb"]
  spec.email         = ["matthias.kalb@railsmechanic.de"]
  spec.summary       = %q{Parser for XML sitemaps}
  spec.description   = %q{Parser for XML sitemaps which respects sitemaps listed in robots.txt and handles gziped and nested sitemaps as well.}
  spec.homepage      = "https://github.com/railsmechanic/sitemaped"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  add_runtime_dependency 'nokogiri', '~> 1.6', '~> 1.6'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
