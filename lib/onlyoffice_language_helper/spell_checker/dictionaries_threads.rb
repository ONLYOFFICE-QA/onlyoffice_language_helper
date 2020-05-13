# frozen_string_literal: true

module OnlyofficeLanguageHelper
  module SpellChecker
    # Threads for spellchecker
    class DictionariesThreads
      attr_accessor :word

      Thread.abort_on_exception = true

      def initialize
        @dictionaries = {}
        Dir.glob("#{SpellChecker.config.dictionaries_path}/dictionaries/*")
           .select { |f| File.directory?(f) }.each do |lang|
          @dictionaries[File.basename(lang)] =
            Hunspell.new(SpellChecker.path_to_dic_aff(:aff,
                                                      File.basename(lang)),
                         SpellChecker.path_to_dic_aff(:dic,
                                                      File.basename(lang)))
        end
      end

      def threads
        @threads ||= init_threads
      end

      def check_word(word)
        @result = {}
        @word = word.to_s
        start_threads
      end

      def start_threads
        threads.each(&:run)
        until @result.length == @dictionaries.length
        end
        @result
      end

      private

      def init_threads_data
        @result = {}
        threads
      end

      def init_threads
        @threads = []
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
    end
  end
end
