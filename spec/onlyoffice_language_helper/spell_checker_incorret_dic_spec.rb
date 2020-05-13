# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::SpellChecker do
  after do
    described_class.reset_config
  end

  it '#configure dictionaries_path' do
    dictionaries_path = '/tmp'
    expect do
      described_class.configure do |config|
        config.dictionaries_path = dictionaries_path
      end
    end.to raise_error(RuntimeError)
  end
end
