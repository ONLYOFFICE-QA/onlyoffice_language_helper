# frozen_string_literal: true

module OnlyofficeLanguageHelper
  module SpellChecker
    # Spellchecker config
    class Config
      # @return [String] language to expect
      attr_accessor :expected_language
      # @return [String] path to lang file
      attr_accessor :dictionaries_path

      def initialize
        default_configuration
      end

      def default_configuration
        @expected_language = 'en_US'
        @dictionaries_path = File.dirname(__dir__)
      end
    end
  end
end
