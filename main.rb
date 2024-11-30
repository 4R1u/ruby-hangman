# frozen_string_literal: true

require_relative 'lib/game'

words_file = File.open('resources/google-10000-english-no-swears.txt')
words = []
while (line = words_file.gets)
  words << line.chomp
end

game = Game.new(words.sample)
until game.over?
  game.attempt(gets.chomp)
  puts game.state
  puts game.tried_letters
end
