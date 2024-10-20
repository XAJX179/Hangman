# frozen_string_literal: true

# Player playing the game
class Player
  attr_accessor :incorrect_letters
  attr_reader :guessed_letters, :correct_letters, :secret_word

  def initialize(guessed_letters = [], correct_letters = [], incorrect_letters = [])
    @guessed_letters = guessed_letters
    @correct_letters = correct_letters
    @incorrect_letters = incorrect_letters
    @secret_word = ''
  end

  def user_input
    gets.chomp[0].to_s.downcase
  end

  def self.load_save
    name = choose_save
    file = File.open("json/#{name}")
    file.rewind
    data = file.read
    JSON.parse(data)
  end

  def self.choose_save
    list_save
    load_file_name
  end

  def self.list_save
    print "Choose from save list :\n"
    puts Dir.children('json')
  end

  def self.load_file_name
    while (input = gets.chomp.downcase)
      break if file_exists?(input)

      print "\e[1A"
    end
    input
  end

  def self.file_exists?(input)
    Dir.children('json').include?(input)
  end
end
