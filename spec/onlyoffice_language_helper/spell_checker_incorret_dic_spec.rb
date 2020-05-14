# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::SpellChecker do
  let(:incorrect_path) { '/tmp' }

  after do
    described_class.reset_config
  end

  it '#configure dictionaries_path' do
    expect do
      described_class.configure do |config|
        config.dictionaries_path = incorrect_path
      end
    end.to raise_error(RuntimeError)
  end
end
