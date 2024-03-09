# frozen_string_literal: true

# This module provides utility methods for the Hangman game.
module Hangman
  class Utils
    DEFAULT_DICTIONARY_FILE = 'data/google-10000-english-no-swears.txt'

    # Loads a dictionary file into an array, filtering words by length.
    #
    # @param file_path [String] Path to the dictionary file.
    # @return [Array<String>] An array containing filtered dictionary words.
    def self.load_dictionary(file_path = nil)
      file_path ||= DEFAULT_DICTIONARY_FILE
      File.foreach(file_path)
          .map { |line| line.strip.upcase }
          .select { |word| word.length.between?(5, 12) }
    end
  end
end
