# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blink_ci/version'

Gem::Specification.new do |gem|
  gem.name          = "blink_ci"
  gem.version       = BlinkCi::VERSION
  gem.authors       = ["Ivo Dancet"]
  gem.email         = ["ivo.dancet@gmail.com"]
  gem.description   = %q{Even faster setup for blink(1) connection to jenkins server}
  gem.summary       = %q{Even faster setup for blink(1) connection to jenkins server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  # gem.add_dependency "blinky", "~>0.0.10"
  gem.add_dependency "chicanery", "0.1.0"
  gem.add_dependency "mixlib-cli", "~>1.3.0"
  gem.add_dependency "rake"
  gem.add_dependency "rb-blink1"

  gem.executables << "blink_ci"
end
