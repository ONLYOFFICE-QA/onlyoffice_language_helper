# encoding=utf-8
require 'hunspell-ffi'
require 'active_support/configurable'
require 'httparty'
require 'json'
require 'cgi'
require 'whatlanguage'

# USAGE:
# SpellChecker.configure do |config|
#  config.expected_language = 'lv_LV'
# end
#
# SpellChecker.check_in_all_dictionaries("viens no veidiem, iespieddarbiem: nav periodisks izdevums")
module OnlyofficeLanguageHelper
  module SpellChecker
    include HTTParty
    attr_reader :config

    def self.configure
      OnlyofficeLoggerHelper.log('Begin configuring SpellChecker')
      config
      yield(@config) if block_given?
      check_language
      @dictionary = Hunspell.new(path_to_dic_aff(:aff), path_to_dic_aff(:dic))
      OnlyofficeLoggerHelper.log('Configuring complete!')
    end

    def self.check_in_all_dictionaries(string)
      check_configuration
      @dictionaries ||= DictionariesThreads.new
      split_text_by_words(string).map { |word| parse_spellcheck_result(word, @dictionaries.check_word(word)) }
    end

    def self.path_to_dic_aff(extension, language = config.expected_language)
      config.dictionaries_path + "/dictionaries/#{language}/#{language}.#{extension}"
    end

    def self.detect_lang_via_whatlanguage(string)
      string.to_s.language
    end

    class Config
      include ActiveSupport::Configurable

      config_accessor :expected_language
      config_accessor :dictionaries_path

      def initialize
        default_configuration
      end

      def default_configuration
        self.expected_language = 'en_US'
        self.dictionaries_path = "#{Dir.pwd}/lib/onlyoffice_language_helper"
      end
    end

    private_class_method

    def self.split_text_by_words(string)
      string.to_s.scan(/\b[[:word:]['-]]+\b/u).uniq
    end

    def self.parse_spellcheck_result(word, spellcheck_result)
      unless spellcheck_result[config.expected_language]
        warn "Word '#{word}' was not found in '#{config.expected_language}' dictionary!"
        spellcheck_result['suggestions'] = @dictionary.suggest(word)
      end
      { word => spellcheck_result }
    end

    def self.config
      @config ||= Config.new
    end

    def self.check_configuration
      raise 'Call SpellChecker.configure method before using it!' unless @dictionary
    end

    def self.check_language
      raise 'Incorrect language' unless File.exist?(path_to_dic_aff(:dic)) || File.exist?(path_to_dic_aff(:aff))
    end

    class DictionariesThreads
      attr_accessor :word

      Thread.abort_on_exception = true

      def initialize
        @dictionaries = {}
        Dir.glob(SpellChecker.config.dictionaries_path + '/dictionaries/*').select { |f| File.directory?(f) }.each do |lang|
          @dictionaries[File.basename(lang)] =
            Hunspell.new(SpellChecker.path_to_dic_aff(:aff, File.basename(lang)),
                         SpellChecker.path_to_dic_aff(:dic, File.basename(lang)))
        end
        @threads ||= init_threads
      end

      def check_word(word)
        @result = {}
        @word = word.to_s
        start_threads
      end

      def init_threads
        @threads = []
        @result = {}
        @dictionaries.each do |key, value|
          @threads << Thread.new do
            loop do
              @result[key] = value.check(@word.to_s)
              Thread.stop
            end
          end
        end
        @threads
      end

      def start_threads
        @threads.each(&:run)
        until @result.length == @dictionaries.length
        end
        @result
      end
    end
  end
end
