# frozen_string_literal: true

module Hangman
  class Utils
    DEFAULT_DICTIONARY_FILE = 'data/google-10000-english-no-swears.txt'

    def self.load_dictionary(file_path = nil)
      file_path ||= DEFAULT_DICTIONARY_FILE
      dictionary = []
      file = File.open(file_path, 'r')
      while (line = file.gets)
        dictionary.push(line.strip.upcase) if line.strip.length.between?(5, 12)
      end
      dictionary
    end
  end
end
