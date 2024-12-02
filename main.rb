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

puts 'Do you want to load a game? (y)'
if gets.chomp == 'y'
  files = Dir.entries('games')
  files.reject { |entry| entry[0] == '.' }.each do |file|
    puts file
    game = Game.from_msgpack(File.open("games/#{file}").gets)
    puts "#{file[0..-4]}:"
    puts "  #{game.state}"
    puts "  #{game.guesses_left} guesses left"
    puts "  Tried letters and words: #{game.tried_strings}"
  end
  choice = 'choice'
  puts "Enter the number of the game you'd like to save:"
  choice = gets.chomp until files.include? "#{choice}.hm"
  game = Game.from_msgpack(File.open("games/#{choice}.hm"))
else
  game = Game.new(words.sample)
end

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
