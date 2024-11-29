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
end
