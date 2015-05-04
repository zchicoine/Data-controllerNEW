# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'Data_Controller/version'

Gem::Specification.new do |spec|
  spec.name          = 'Data_Controller'
  spec.version       = DataController::VERSION
  spec.authors       = ['The Ship Network']
  spec.email         = ['hassoun@outlook.com']
  spec.summary       = %q{todo: Write a short summary. Required.}
  spec.description   = %q{Data Controller is responsible for  accessing databases for write and read operation}
  spec.homepage      = 'http://theshipnetwork.herokuapp.com/'
  spec.license       = ''
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake','~> 10.4.2'
end
