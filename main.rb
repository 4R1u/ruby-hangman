# frozen_string_literal: true

require_relative 'lib/game'

words_file = File.open('resources/google-10000-english-no-swears.txt')
words = []
while (line = words_file.gets)
  line.chomp!
  words << line if (5..12).include?(line.length)
end

puts 'The game will choose a random word between 5 and 12 words long.'
game = Game.new(words.sample)
until game.over?
  print "Enter a letter to see if it\'s in the word,"
  puts ' or a word itself you think is the answer.'
  game.attempt(gets.chomp)
  puts game.state
  p game.tried_strings
end
puts game.won? ? 'You won!' : 'You lost!'
