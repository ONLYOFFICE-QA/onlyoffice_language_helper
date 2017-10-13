require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::SpellChecker do
  expected_language = 'lv_LV'

  before do
    OnlyofficeLanguageHelper::SpellChecker.configure do |config|
      config.expected_language = expected_language
    end
  end

  it '#configure language' do
    expect(OnlyofficeLanguageHelper::SpellChecker.config.expected_language).to eq(expected_language)
  end

  it '#check_in_all_dictionaries correct' do
    expect(OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('viens').first['viens']['lv_LV']).to be true
    expect(OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('viens').first['viens']['en_US']).to be false
  end

  it '#check_in_all_dictionaries incorrect' do
    expect(OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('hello').first['hello']['lv_LV']).to be false
    expect(OnlyofficeLanguageHelper::SpellChecker.check_in_all_dictionaries('hello').first['hello']['en_US']).to be true
  end

  it '#configure dictionaries_path' do
    dictionaries_path = '/tmp'
    expect do
      OnlyofficeLanguageHelper::SpellChecker.configure do |config|
        config.dictionaries_path = dictionaries_path
      end
    end.to raise_error(RuntimeError)
  end
end
