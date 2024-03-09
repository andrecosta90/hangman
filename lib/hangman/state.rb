# frozen_string_literal: true
require_relative 'serializable'

module Hangman
  class State
    include BasicSerializable
    attr_reader :correct_letters, :incorrect_letters, :max_guesses

    def initialize(secret_word, max_guesses = 6)
      @secret_word = secret_word
      @correct_letters = Array.new(secret_word.length, '_') # state
      @incorrect_letters = [] # state
      @max_guesses = max_guesses
    end

    def update(letter)
      if @secret_word.include?(letter)
        @correct_letters = correct_letters.each_with_index.map { |el, idx| @secret_word[idx] == letter ? letter : el }
      else
        @incorrect_letters.push(letter)
      end
    end

    def out_of_guesses?
      incorrect_letters.length == max_guesses
    end

    def secret_word
      return @secret_word if out_of_guesses?

      '*****'
    end

    def win?
      @secret_word == correct_letters.join('')
    end

    def info
      puts "\nCorrect letters: #{correct_letters.join(' ')}  ::  (##{correct_letters.length} letters)"
      puts "\n#'s of incorrect guesses remaining: #{max_guesses - incorrect_letters.length}"
      puts "Incorrect letters: [#{incorrect_letters.join(', ')}]\n\n"
      puts "===========================================================\n\n"
    end
  end
end
