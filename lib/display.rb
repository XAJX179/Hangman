# frozen_string_literal: true

# Display on terminal
class Display
  def draw(incorrect_letters)
    print "\t\t                 ┏────────────\n"
    print "\t\t                 |            \n"
    head(incorrect_letters)
    torso_and_arms(incorrect_letters)
    legs(incorrect_letters)
  end

  def head(incorrect_letters)
    print "\t\t                 "
    print incorrect_letters.length >= 1 ? '0' : ' '
    print "            \n"
  end

  def torso_and_arms(incorrect_letters)
    print "\t\t                "
    print incorrect_letters.length >= 3 ? '/' : ' '
    print incorrect_letters.length >= 2 ? '|' : ' '
    print incorrect_letters.length >= 4 ? '\\' : ' '
    print "            \n"
  end

  def legs(incorrect_letters)
    print "\t\t                "
    print incorrect_letters.length >= 5 ? '/ ' : ' '
    print incorrect_letters.length >= 6 ? '\\' : ' '
    print "           \n\n"
  end

  def redraw(incorrect_letters)
    print "\033[13A"
    draw(incorrect_letters)
  end
end
