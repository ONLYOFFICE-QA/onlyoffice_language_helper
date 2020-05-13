# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::DetectLanguageWrapper do
  it 'get list of all languages' do
    expect(described_class.all_languages).to be_a(Array)
  end

  it 'check word for language' do
    expect(described_class
               .detect_language('Buongiorno')
               .first['language']).to eq('it')
  end
end
