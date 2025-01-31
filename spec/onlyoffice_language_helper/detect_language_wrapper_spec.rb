# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlyofficeLanguageHelper::DetectLanguageWrapper do
  before do
    described_class.reset_keys
  end

  it 'get list of all languages' do
    expect(described_class.all_languages).to be_a(Array)
  end

  it 'check word for language' do
    expect(described_class
               .detect_language('Buongiorno')
               .first['language']).to eq('it')
  end

  it 'raises an error when no keys are found' do
    allow(OnlyofficeFileHelper::FileHelper).to receive(:read_array_from_file).and_raise(Errno::ENOENT)
    expect { described_class.detect_language('Hello') }.to raise_error(Errno::ENOENT, /No keys found/)
  end

  it 'raises an error when all API keys are non-active' do
    allow(DetectLanguage).to receive(:user_status).and_return({ 'status' => 'INACTIVE' })
    allow(described_class).to receive(:read_keys).and_return(['fake_key'])

    expect do
      described_class.detect_language('Hello')
    end.to raise_error(RuntimeError, /All keys are non-active/)
  end

  it 'uses ENV key if present' do
    original_env_key = ENV['DETECT_LANGUAGE_KEY']
    ENV['DETECT_LANGUAGE_KEY'] = 'env_key'
    expect(described_class.send(:read_keys)).to eq(['env_key'])
    ENV['DETECT_LANGUAGE_KEY'] = original_env_key
  end
end
