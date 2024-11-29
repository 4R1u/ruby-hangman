# frozen_string_literal: true

# This represents an instance of the hangman game.
class Game
  def initialize(word)
    @word = word
    @guesses_left = 8
    @state = '_' * word.size
    @wrong_letters = ''
  end
end
