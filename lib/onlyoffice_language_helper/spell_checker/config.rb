module OnlyofficeLanguageHelper
  module SpellChecker
    # Spellchecker config
    class Config
      include ActiveSupport::Configurable

      config_accessor :expected_language
      config_accessor :dictionaries_path

      def initialize
        default_configuration
      end

      def default_configuration
        self.expected_language = 'en_US'
        self.dictionaries_path = File.dirname(__dir__)
      end
    end
  end
end
