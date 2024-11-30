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

  def attempt(string)
    return if @guesses_left.zero? ||
              @tried_letters.include?(string) ||
              string.downcase.chars.all?(('a'..'z'))

    string.length == 1 ? attempt_letter(string) : attempt_word(string)
  end

  def over?
    won? || lost?
  end

  def won?
    !@state.include?('_')
  end

  def lost?
    @state.include?('_') && @guesses_left.zero?
  end

  private

  def attempt_word(word)
    @state = word if @guesses_left.positive? && word == @word
    @guesses_left -= 1
  end

  def attempt_letter(letter)
    @word.chars.each_with_index do |char, index|
      @state[index] = letter if letter == char
    end
    @tried_letters += letter
    @guesses_left -= 1
  end
end
