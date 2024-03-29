# frozen_string_literal: true

require_relative 'hangman/utils'
require_relative 'hangman/state'

require 'readline'

module Hangman
  # This class represents the Hangman game.
  class Game
    attr_reader :dictionary

    def initialize
      @dictionary = Hangman::Utils.load_dictionary
    end

    # Starts the Hangman game.
    def start
      puts '========================='
      puts 'Welcome to Hangman Game!'
      puts "\t1 - New game"
      puts "\t2 - Load game"
      puts '========================='
      select_option
    end

    private

    # Allows the player to choose between starting a new game or loading a saved game.
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
      play(State.new(dictionary.sample))
    end

    def load_game(file_path)
      puts "Loading a game path=#{file_path}..."
      play(State.unserialize(File.read(file_path)))
    rescue Errno::ENOENT
      puts "\nFile not found: #{file_path}\n\n"
    rescue JSON::ParserError
      puts "\nInvalid file format: #{file_path}\n\n"
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

    # Prompts the player to guess a letter.
    #
    # @return [String] The guessed letter.
    def guess_a_letter
      print 'Guess one letter: '
      gets.chomp.upcase
    end

    # Prompts the player to guess a letter and continues the game loop.
    #
    # @param state [State] The current game state.
    def play(state)
      loop do
        state.info

        break puts "You Win! CONGRATULATIONS !!! Correct word = #{state.secret_word}\n\n" if state.win?
        break puts "You Lose! You are out of guesses! Correct word = #{state.secret_word}\n\n" if state.out_of_guesses?

        state.update!(guess_a_letter)

        puts "\nWould you like to save the game? 1 - yes ; other - NO\n"
        option = gets.to_i
        break save_game(state) if option == 1
      end
    end
  end
end

game = Hangman::Game.new
game.start
