# frozen_string_literal: true

# Player playing the game
class Player
  attr_accessor :incorrect_letters
  attr_reader :guessed_letters, :correct_letters

  def initialize
    @guessed_letters = []
    @correct_letters = []
    @incorrect_letters = []
  end

  def user_input
    gets.chomp[0].to_s.downcase
  end
end
