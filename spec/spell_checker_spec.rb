# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::SpellChecker do
  expected_language = 'lv_LV'

  before do
    described_class.configure do |config|
      config.expected_language = expected_language
    end
  end

  it '#configure language' do
    expect(described_class.config.expected_language).to eq(expected_language)
  end

  it '#check_in_all_dictionaries correct' do
    word = described_class.check_in_all_dictionaries('viens')
                          .first['viens']
    expect(word['lv_LV']).to be true
    expect(word['en_US']).to be false
  end

  it '#check_in_all_dictionaries incorrect' do
    word = described_class.check_in_all_dictionaries('hello')
                          .first['hello']
    expect(word['lv_LV']).to be false
    expect(word['en_US']).to be true
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
