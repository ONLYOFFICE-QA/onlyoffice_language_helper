require 'detect_language'
require 'onlyoffice_file_helper'

module OnlyofficeLanguageHelper
  # Code for detect language via API of detectlanguage.com
  class Detect_Language
    class << self
      # @return [Array, String] initialized keys
      attr_accessor :keys

      def detect_language(text)
        change_key_on_active
        DetectLanguage.detect(text)
      end

      def get_all_languages
        change_key_on_active
        DetectLanguage.languages
      end

      private

      # Set value to variable Detect_Language.keys
      # @return [Array, String] list of keys
      def read_keys
        return [ENV['DETECT_LANGUAGE_KEY']] if ENV['DETECT_LANGUAGE_KEY']
        OnlyofficeFileHelper::FileHelper.read_array_from_file(Dir.home + '/.detect_language/keys')
      rescue Errno::ENOENT
        raise Errno::ENOENT, "No keys found in #{Dir.home}/.detect_language/ directory." \
        "Please create files #{Dir.home}/.detect_language/keys"
      end

      def change_key_on_active
        Detect_Language.keys ||= read_keys
        Detect_Language.keys.each do |key|
          DetectLanguage.configure do |config|
            config.api_key = key
          end
          return if DetectLanguage.user_status['status'] == 'ACTIVE'
        end
        raise 'All keys are non-active. Please register more detectlanguage.com accounts'
      end
    end
  end
end
