# frozen_string_literal: true

require_relative 'lib/game'

def save_game(game)
  FileUtils.mkdir_p('games')
  file_number = Dir.entries('games').map(&:to_i).max
  File.open("games/#{file_number + 1}.hm", 'w') << game.to_msgpack
end

words_file = File.open('resources/google-10000-english-no-swears.txt')
words = []
while (line = words_file.gets)
  line.chomp!
  words << line if (5..12).include?(line.length)
end

puts 'The game will choose a random word between 5 and 12 words long.'
game = Game.new(words.sample)
until game.over?
  puts 'Would you like to save? (y)'
  save_game(game) if gets.chomp == 'y'
  print "Enter a letter to see if it's in the word,"
  puts ' or a word itself you think is the answer.'
  game.attempt(gets.chomp)
  puts game.state
  p game.tried_strings
end
puts game.won? ? 'You won!' : 'You lost!'
