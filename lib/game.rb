# frozen_string_literal: true

require_relative 'hangman/display'

class Game
  def run
    Hangman::Display.welcome
    loop do
      print 'Choose a option: '
      option = gets.to_i

      new_game if option == 1
      load_game('path/to/game') if option == 2
      break if option.between?(1, 2)

      puts "\nInvalid option! ** #{option} **\n"
    end
  end

  def new_game
    puts 'Running new game...'
  end

  def load_game(file_path)
    puts "Loading a game path=#{file_path}..."
  end
end

game = Game.new
game.run
