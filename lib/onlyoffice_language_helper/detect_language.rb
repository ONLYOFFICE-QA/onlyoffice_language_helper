# frozen_string_literal: true

require 'detect_language'
require 'onlyoffice_file_helper'

module OnlyofficeLanguageHelper
  # Code for detect language via API of detectlanguage.com
  class DetectLanguageWrapper
    class << self
      # @return [Array, String] initialized keys
      attr_accessor :api_keys

      # Detect language of text
      # @param text [String] text to detect
      # @return [String] possible language
      def detect_language(text)
        change_key_on_active
        DetectLanguage.detect(text)
      end

      # @return [Array<String>] list of all possible languages
      def all_languages
        change_key_on_active
        DetectLanguage.languages
      end

      private

      # Set value to variable DetectLanguageWrapper.keys
      # @return [Array, String] list of keys
      def read_keys
        # rubocop:disable Style/FetchEnvVar
        return [ENV['DETECT_LANGUAGE_KEY']] if ENV.key?('DETECT_LANGUAGE_KEY')
        # rubocop:enable Style/FetchEnvVar

        OnlyofficeFileHelper::FileHelper
          .read_array_from_file("#{Dir.home}/.detect_language/keys")
      rescue Errno::ENOENT
        raise Errno::ENOENT,
              "No keys found in #{Dir.home}/.detect_language/ directory." \
              "Please create files #{Dir.home}/.detect_language/keys"
      end

      def change_key_on_active
        DetectLanguageWrapper.api_keys ||= read_keys
        DetectLanguageWrapper.api_keys.each do |key|
          DetectLanguage.configure do |config|
            config.api_key = key
          end
          return true if DetectLanguage.user_status['status'] == 'ACTIVE'
        end
        raise 'All keys are non-active. ' \
              'Please register more detectlanguage.com accounts'
      end
    end
  end
end
