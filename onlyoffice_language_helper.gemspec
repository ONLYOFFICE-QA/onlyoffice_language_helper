# frozen_string_literal: true

require_relative 'lib/onlyoffice_language_helper/name'
require_relative 'lib/onlyoffice_language_helper/version'

Gem::Specification.new do |s|
  s.name = OnlyofficeLanguageHelper::NAME
  s.version = OnlyofficeLanguageHelper::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.1'
  s.authors = ['ONLYOFFICE', 'Pavel Lobashov']
  s.email = %w[shockwavenn@gmail.com]
  s.summary = 'ONLYOFFICE Helper Gem for language operation'
  s.description = 'ONLYOFFICE Helper Gem for language operation. Used in QA'
  s.homepage = "https://github.com/ONLYOFFICE-QA/#{s.name}"
  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'changelog_uri' => "#{s.homepage}/blob/master/CHANGELOG.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{s.name}",
    'source_code_uri' => s.homepage,
    'rubygems_mfa_required' => 'true'
  }
  s.files = Dir['lib/**/*']
  s.license = 'AGPL-3.0-or-later'
  s.add_dependency('detect_language', '~> 1')
  s.add_dependency('ffi-hunspell', '~> 0')
  s.add_dependency('httparty', '~> 0.10', '>= 0.21.0')
  s.add_dependency('onlyoffice_file_helper', '< 3')
  s.add_dependency('onlyoffice_logger_helper', '~> 1')
  s.add_dependency('whatlanguage', '~> 1')
end
