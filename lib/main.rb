# frozen_string_literal: true

DEFAULT_DICTIONARY_FILE = 'data/google-10000-english-no-swears.txt'

def load_dictionary(file_path = nil)
  file_path ||= DEFAULT_DICTIONARY_FILE
  dictionary = []
  file = File.open(file_path, 'r')
  while (line = file.gets)
    dictionary.push(line.strip.upcase) if line.strip.length.between?(5, 12)
  end
  dictionary
end

max_guesses = 6

# 2.1 your script should load in the dictionary
# 2.2 and randomly select a word between 5 and 12 characters long for the secret word
dictionary = load_dictionary
# p dictionary.length
secret_word = 'programming'.upcase # state
secret_word = dictionary.sample
correct_letters = Array.new(secret_word.length, '_') # state
incorrect_letters = [] # state

loop do
  puts "\nCorrect letters: #{correct_letters.join(' ')}  ::  (##{correct_letters.length} letters)"
  puts "\n#'s of incorrect guesses remaining: #{max_guesses - incorrect_letters.length}"
  puts "Incorrect letters: [#{incorrect_letters.join(', ')}]\n\n"
  puts "===========================================================\n\n"

  break puts 'You Win! CONGRATULATIONS !!! \n\n' if secret_word == correct_letters.join('')
  if incorrect_letters.length == max_guesses
    break puts "You Lose! You are out of guesses! Correct word = #{secret_word}\n\n"
  end

  print 'Guess one letter: '
  letter = gets.chomp.upcase
  if secret_word.include?(letter)
    correct_letters = correct_letters.each_with_index.map { |el, idx| secret_word[idx] == letter ? letter : el }
  else
    incorrect_letters.push(letter)
  end
end
