# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::Detect_Language do
  it 'get list of all languages' do
    expect(OnlyofficeLanguageHelper::Detect_Language.get_all_languages).to be_a(Array)
  end

  it 'check word for language' do
    expect(OnlyofficeLanguageHelper::Detect_Language.detect_language('Buongiorno').first['language']).to eq('it')
  end
end
