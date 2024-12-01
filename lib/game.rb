# frozen_string_literal: true

require 'msgpack'

# This represents an instance of the hangman game.
class Game
  attr_reader :guesses_left, :state, :tried_strings

  def initialize(word, guesses_left = 8, state = ('_' * word.length), tried_strings = [])
    @word = word
    @guesses_left = guesses_left <= 8 ? guesses_left : 8
    @state = state.length == word.length ? state : '_' * word.length
    @tried_strings = tried_strings.is_a?(Array) ? tried_strings : []
  end

  def attempt(string)
    return if @guesses_left.zero? ||
              @tried_strings.include?(string) ||
              !string.downcase.chars.all?(('a'..'z'))

    if string.length == 1
      attempt_letter(string.downcase)
    else
      attempt_word(string.downcase)
    end
    puts @word if lost?
  end

  def to_msgpack
    MessagePack.dump({
                       word: @word,
                       guesses_left: @guesses_left,
                       state: @state,
                       tried_strings: @tried_strings
                     })
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
    @tried_strings.push(word)
    @guesses_left -= 1
  end

  def attempt_letter(letter)
    @word.chars.each_with_index do |char, index|
      @state[index] = letter if letter == char
    end
    @tried_strings.push(letter)
    @guesses_left -= 1
  end
end
