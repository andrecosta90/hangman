# frozen_string_literal: true

require 'json'

module Hangman
  # Represents the state of the Hangman game.
  class State
    attr_reader :correct_letters, :incorrect_letters, :max_guesses

    # Initializes a new instance of the State class.
    #
    # @param secret_word [String] The secret word to guess.
    # @param max_guesses [Integer] The maximum number of incorrect guesses allowed.
    # @param correct_letters [Array<String>] An array of correctly guessed letters.
    # @param incorrect_letters [Array<String>] An array of incorrectly guessed letters.
    def initialize(secret_word, max_guesses = 6, correct_letters = nil, incorrect_letters = nil)
      @secret_word = secret_word
      @correct_letters = correct_letters || Array.new(secret_word.length, '_') # state
      @incorrect_letters = incorrect_letters || [] # state
      @max_guesses = max_guesses
    end

    # Updates the state based on a guessed letter.
    #
    # @param letter [String] The letter guessed by the player.
    def update!(letter)
      if @secret_word.include?(letter)
        @correct_letters = correct_letters.each_with_index.map { |el, idx| @secret_word[idx] == letter ? letter : el }
      else
        @incorrect_letters.push(letter)
      end
    end

    # Checks if the player is out of guesses.
    #
    # @return [Boolean] True if the player is out of guesses, otherwise false.
    def out_of_guesses?
      incorrect_letters.length == max_guesses
    end

    def secret_word
      out_of_guesses? || win? ? @secret_word : '*****'
    end

    # Checks if the player has won the game.
    #
    # @return [Boolean] True if the player has won, otherwise false.
    def win?
      @secret_word == correct_letters.join('')
    end

    # Displays the game information.
    def info
      puts "\nCorrect letters: #{correct_letters.join(' ')}  ::  (##{correct_letters.length} letters)"
      puts "\n#'s of incorrect guesses remaining: #{max_guesses - incorrect_letters.length}"
      puts "Incorrect letters: [#{incorrect_letters.join(', ')}]\n\n"
      puts "===========================================================\n\n"
    end

    def to_s
      "@secret_word=#{secret_word}, " \
        "@correct_letters=#{correct_letters}, " \
        "@incorrect_letters=#{incorrect_letters}, " \
        "@max_guesses=#{max_guesses}>"
    end

    # Serializes the State object to a JSON string.
    #
    # @return [String] A JSON representation of the State object.
    def serialize
      JSON.dump({
                  secret_word: @secret_word,
                  max_guesses: @max_guesses,
                  correct_letters: @correct_letters,
                  incorrect_letters: @incorrect_letters
                })
    end

    # Deserializes a JSON string into a State object.
    #
    # @param string [String] The JSON string to deserialize.
    # @return [State] A State object deserialized from the JSON string.
    def self.unserialize(string)
      data = JSON.parse string
      new(data['secret_word'],
          data['max_guesses'],
          data['correct_letters'],
          data['incorrect_letters'])
    end
  end
end
