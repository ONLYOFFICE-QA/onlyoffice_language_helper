# frozen_string_literal: true

require 'hunspell-ffi'
require 'httparty'
require 'json'
require 'cgi'
require 'whatlanguage'
require_relative 'spell_checker/config'
require_relative 'spell_checker/dictionaries_threads'

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
      @dictionary = Hunspell.new(path_to_dic_aff(:aff),
                                 path_to_dic_aff(:dic))
      OnlyofficeLoggerHelper.log('Configuring complete!')
    end

    # Check in all known dictionaries
    # @param string [String] string to check
    # @return [Array<Hash>] result of check
    def self.check_in_all_dictionaries(string)
      check_configuration
      @dictionaries ||= DictionariesThreads.new
      split_text_by_words(string).map do |word|
        parse_spellcheck_result(word,
                                @dictionaries.check_word(word))
      end
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

    # Parse spellchecker result
    # @param word [String] word to check
    # @param spellcheck_result [Hash] param to set result
    # @return [Hash] value of result
    def self.parse_spellcheck_result(word, spellcheck_result)
      unless spellcheck_result[config.expected_language]
        warn("Word '#{word}' was not found in "\
             "'#{config.expected_language}' dictionary!")
        spellcheck_result['suggestions'] = @dictionary.suggest(word)
      end
      { word => spellcheck_result }
    end

    # @return [Config] get current config
    def self.config
      @config ||= Config.new
    end

    # @return [nil] Reset config to default
    def self.reset_config
      @config = Config.new
    end

    # @return [nil] check if current config is right
    def self.check_configuration
      return if @dictionary

      raise 'Call SpellChecker.configure method before using it!'
    end

    # @return [nil] check if current language has dictonaries
    def self.check_language
      unless File.exist?(path_to_dic_aff(:dic)) ||
             File.exist?(path_to_dic_aff(:aff))
        raise 'Incorrect language'
      end
    end
  end
end
