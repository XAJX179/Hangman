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

  def save_game(secret_word)
    name = choose_name
    file = File.open("json/#{name}.json", 'w')
    file.rewind
    data = JSON.dump({ 'guessed_letters' => @guessed_letters,
                       'correct_letters' => @correct_letters,
                       'incorrect_letters' => @incorrect_letters,
                       'secret_word' => secret_word })
    file.write(data)
  end

  def choose_name
    print 'Enter a name for save (alphabets only) : '
    while (input = gets.chomp.downcase)
      break if valid_save?(input)

      print "\e[1AEnter a name for save (alphabets only) : "
    end
    input
  end

  def valid_save?(input)
    length = input.scan(/[a-z]/).length
    length == input.length && input.length.positive?
  end

  def self.load_save
    name = choose_save
    file = File.open("json/#{name}.json")
    file.rewind
    data = file.read
    JSON.parse(data)
  end

  def self.choose_save
    list_save
    load_file_name
  end

  def self.list_save
    print "Save list :\n"
    Dir.children('json').each do |e|
      puts File.basename(e, '.json')
    end
  end

  def self.load_file_name
    print 'Choose one from save list (alphabets only): '
    while (input = gets.chomp.downcase)
      break if file_exists?("#{input}.json")

      print "\e[1AChoose one from save list (alphabets only): "
    end
    input
  end

  def self.file_exists?(input)
    Dir.children('json').include?(input)
  end
end
