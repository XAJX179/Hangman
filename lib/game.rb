# frozen_string_literal: true

# Hangman Game class
class Game
  def initialize
    @secret_word = ''
  end

  def start
    file = load_word_file
    @secret_word = random_word(file)
    display = Display.new
    player = load_saved_or_not
    display.draw(player.incorrect_letters)
    messages(player)
    gameloop(player, display)
  end

  private

  def load_saved_or_not
    puts 'Do you wanna load a save? (y/n)'
    input = confirm
    input == 'y' ? load_save : Player.new
  end

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

  def messages(player)
    puts "incorrect letters = #{player.incorrect_letters.join(',')}  #{player.incorrect_letters.length} of 6 \n\n"
    puts "correct letters = #{correct_letters(player).join(' ')}\n\n"
    puts 'guess one correct letter of word :'
  end

  def correct_letters(player)
    @secret_word.chars.map do |e|
      player.correct_letters.include?(e) ? e : '_'
    end
  end

  def gameloop(player, display)
    while running(player)
      break if save_and_exit

      puts "\nprompt \n\n"
      while (input = player.user_input)
        print "\033[1A"
        break if input_valid?(input, player)
      end
      handle_guess(input, player)
      redraw(display, player)
    end
    result(player)
  end

  def confirm
    while (input = gets.chomp.downcase)
      print "\033[1A"
      break if input.match(/[y,n]/)
    end
  end

  def save_and_exit
    puts 'Do you wanna save and exit? (y/n)'
    input = confirm
    input == 'y' ? save_game : false
  end

  def running(player)
    if filter_correct(player).length == @secret_word.length
      false
    else
      player.incorrect_letters.length < 6
    end
  end

  # removing '_' from correct_letters(player)
  def filter_correct(player)
    correct_letters(player).select { |e| e.match(/[a-z]/) }
  end

  def input_valid?(input, player)
    !player.guessed_letters.include?(input) && !input.empty? && input.match(/[a-z]/)
  end

  def handle_guess(input, player)
    player.guessed_letters.push(input)
    if @secret_word.include?(input)
      player.correct_letters.push(input)
    else
      player.incorrect_letters.push(input)
    end
  end

  def redraw(display, player)
    display.redraw(player.incorrect_letters)
    messages(player)
  end

  def result(player)
    if player.incorrect_letters.length == 6
      puts 'You couldn\'t save him hehe.          '
      puts "word was : #{@secret_word}"
    else
      puts 'You win , but i\'ll get him next time.'
    end
    puts "\n\n\n\n"
  end
end
