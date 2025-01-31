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

  it '#configure without block' do
    expect { described_class.configure }.not_to raise_error
  end

  it '#configure with block' do
    expect do
      described_class.configure do |config|
        config.expected_language = 'en_US'
      end
    end.not_to raise_error
    expect(described_class.config.expected_language).to eq('en_US')
  end

  describe 'correct word for non-english language' do
    it 'correct word for latvian' do
      expect(latvian_word['lv_LV']).to be true
    end

    it 'incorrect word for english' do
      expect(latvian_word['en_US']).to be false
    end
  end

  describe 'correct word for english language' do
    it 'incorrect word for latvian' do
      expect(english_word['lv_LV']).to be false
    end

    it 'correct word for english' do
      expect(english_word['en_US']).to be true
    end
  end
end
