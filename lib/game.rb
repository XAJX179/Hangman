# frozen_string_literal: true

# Game class
class Game
  def start
    file = load_word_file
    puts file.read
  end

  def load_word_file
    File.open('google-10000-english-no-swears.txt')
  end
end
