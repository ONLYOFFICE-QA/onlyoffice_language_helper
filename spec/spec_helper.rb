# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'bundler/setup'
require 'onlyoffice_language_helper'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# @return [String] latvian word
def latvian_word
  OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('viens')
                                        .first['viens']
end

# @return [String] english word
def english_word
  OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('hello')
                                        .first['hello']
end
