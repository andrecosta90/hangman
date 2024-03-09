# frozen_string_literal: true

require_relative 'hangman/display'
require_relative 'hangman/utils'
require_relative 'hangman/state'

require 'readline'

module Hangman
  class Game
    attr_reader :dictionary

    def initialize
      @dictionary = Hangman::Utils.load_dictionary
    end

    def start
      Hangman::Display.welcome
      select_option
    end

    def select_option
      loop do
        print 'Choose a option: '
        option = gets.to_i

        new_game if option == 1
        load_game(Readline.readline('Enter file name: ').strip) if option == 2

        break if option.between?(1, 2)

        puts "\nInvalid option! ** #{option} **\n\n"
      end
    end

    def new_game
      puts "\nRunning new game...\n\n"
      state = State.new(dictionary.sample)
      play(state)
    end

    def load_game(file_path)
      puts "Loading a game path=#{file_path}..."
      state = State.unserialize(File.read(file_path))
      play(state)
    end

    def save_game(state)
      path = File.join(File.dirname(__FILE__), '../appdata')
      Dir.mkdir(path) unless Dir.exist?(path)
      id = Time.now.utc.strftime('%Y%m%d_%H%M%S')
      filename = "#{path}/hangman_#{id}.json"
      File.open(filename, 'w') do |file|
        file.puts state.serialize
      end
      puts "Saving in #{filename}\n\n"
    end

    private

    def guess_a_letter
      print 'Guess one letter: '
      gets.chomp.upcase
    end

    def play(state)
      loop do
        state.info

        break puts "You Win! CONGRATULATIONS !!! Correct word = #{state.secret_word}\n\n" if state.win?
        break puts "You Lose! You are out of guesses! Correct word = #{state.secret_word}\n\n" if state.out_of_guesses?

        state.update(guess_a_letter)

        puts "\nWould you like to save the game? 1 - yes ; other - NO\n"
        option = gets.to_i
        break save_game(state) if option == 1
      end
    end
  end
end

game = Hangman::Game.new
game.start
