# frozen_string_literal: true

# This represents an instance of the hangman game.
class Game
  attr_reader :guesses_left, :state, :tried_letters

  def initialize(word)
    @word = word
    @guesses_left = 8
    @state = '_' * word.length
    @tried_letters = ''
  end

  def attempt(letter)
    return if @guesses_left.zero? ||
              !(('A'..'Z').include?(letter) ||
                ('a'..'z').include?(letter)) ||
              @tried_letters.include?(letter)

    @word.chars.each_with_index do |char, index|
      @state[index] = letter if letter == char
    end
    @tried_letters << letter
    nil
  end
end
