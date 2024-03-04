# frozen_string_literal: true

module Hangman
  class Display
    def self.welcome
      puts '========================='
      puts 'Welcome to Hangman Game!'
      puts "\t1 - New game"
      puts "\t2 - Load game"
      puts '========================='
    end
  end
end
