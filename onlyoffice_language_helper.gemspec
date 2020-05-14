# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'onlyoffice_language_helper/version'
Gem::Specification.new do |s|
  s.name = 'onlyoffice_language_helper'
  s.version = OnlyofficeLanguageHelper::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['ONLYOFFICE', 'Pavel Lobashov']
  s.summary = 'ONLYOFFICE Helper Gem for language operation'
  s.description = 'ONLYOFFICE Helper Gem for language operation. Used in QA'
  s.email = ['shockwavenn@gmail.com']
  s.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  s.homepage = 'https://github.com/onlyoffice-testing-robot/onlyoffice_language_helper'
  s.add_runtime_dependency('detect_language', '~> 1.0')
  s.add_runtime_dependency('httparty', '~> 0.1')
  s.add_runtime_dependency('hunspell-ffi', '~> 0.1')
  s.add_runtime_dependency('onlyoffice_file_helper', '~> 0.1')
  s.add_runtime_dependency('onlyoffice_logger_helper', '~> 1')
  s.add_runtime_dependency('whatlanguage', '~> 1.0')
  s.license = 'AGPL-3.0'
end
