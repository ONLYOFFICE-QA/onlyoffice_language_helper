# frozen_string_literal: true

require 'ffi/hunspell'
require 'httparty'
require 'json'
require 'cgi'
require 'whatlanguage'
require_relative 'spell_checker/config'

# Spellchecker stuff
module OnlyofficeLanguageHelper
  # USAGE:
  # SpellChecker.configure do |config|
  #  config.expected_language = 'lv_LV'
  # end
  #
  # SpellChecker.check_in_all_dictionaries("viens no veidiem,
  #  iespieddarbiem: nav periodisks izdevums")
  module SpellChecker
    include HTTParty
    attr_reader :config

    # Configure Spellchecker
    def self.configure
      OnlyofficeLoggerHelper.log('Begin configuring SpellChecker')
      config
      yield(@config) if block_given?
      check_language
      FFI::Hunspell.directories = all_languages_diconaries
      OnlyofficeLoggerHelper.log('Configuring complete!')
    end

    # Check in all known dictionaries
    # @param string [String] string to check
    # @return [Array<Hash>] result of check
    def self.check_in_all_dictionaries(string)
      results = []
      split_text_by_words(string).map do |word|
        word_results = {}
        available_languages.each do |language|
          FFI::Hunspell.dict(language) do |dict|
            check_result = dict.check?(word)
            word_results[language] = check_result
          end
        end
        word_hash = {}
        word_hash[word] = word_results
        results << word_hash
      end
      results
    end

    # Get path to dic aff
    # @param extension [String] extension of dictionaries
    # @param language [String] language to get
    # @return [String] path
    def self.path_to_dic_aff(extension, language = config.expected_language)
      "#{config.dictionaries_path}/dictionaries/"\
        "#{language}/#{language}.#{extension}"
    end

    # Split text by words
    # @param string [String] multi-word text
    # @return [Array<String>] uniq words
    def self.split_text_by_words(string)
      string.to_s.scan(/\b[[:word:]['-]]+\b/u).uniq
    end

    # @return [Config] get current config
    def self.config
      @config ||= Config.new
    end

    # @return [nil] Reset config to default
    def self.reset_config
      @config = Config.new
    end

    # @return [nil] check if current language has dictonaries
    def self.check_language
      unless File.exist?(path_to_dic_aff(:dic)) ||
             File.exist?(path_to_dic_aff(:aff))
        raise 'Incorrect language'
      end
    end

    # @return [Array<String>] list of available dictonaries
    def self.available_languages
      all_languages_diconaries.map { |dir| File.basename(dir) }
    end

    # @return [Array<String>] list of all dictionaries dir
    def self.all_languages_diconaries
      Dir.glob("#{Dir.pwd}/lib/onlyoffice_language_helper/dictionaries/*").select do |fn|
        File.directory?(fn)
      end
    end
  end
end
