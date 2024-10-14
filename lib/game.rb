# frozen_string_literal: true

# Game class
class Game
  def start
    file = load_word_file
    random_word = random_word(file)
    puts "return : #{random_word}"
  end

  private

  # load words file
  def load_word_file
    File.open('google-10000-english-no-swears.txt')
  rescue StandardError
    puts 'word file does not exists.'
  end

  # return random word of length 5-12 from loaded file
  def random_word(file)
    words = file.readlines(chomp: true) # chomps \n
    words.shuffle! until words[0].length >= 5 && words[0].length <= 12
    words[0]
  end
end
