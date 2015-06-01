# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/wikidata/version'


Gem::Specification.new do |spec|
  spec.name          = "jekyll-wikidata"
  spec.version       = Jekyll::Wikidata::VERSION
  spec.authors       = ["Ed Summers"]
  spec.email         = ["ehs@pobox.com"]
  spec.summary       = "A Jekyll plugin for Wikidata"
  spec.homepage      = "http://github.com/edsu/jekyll-wikidata"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "wikidata-client" 
  spec.add_dependency "jekyll"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.6"

  spec.group :jekyll_plugins
end
