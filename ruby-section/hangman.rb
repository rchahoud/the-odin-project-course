# To correct: bug when the user only press the enter key without any letter
class Gallows
  attr_accessor :secret_word, :lives, :hidden_word, :used_letters

  def initialize()
    @secret_word = generate_random_word()
    puts "random word: #{@secret_word}"
    @hidden_word = set_blank_word(@secret_word)
    @lives = 5
    @used_letters = []
  end

  def generate_random_word()
    lines = File.readlines('google-10000-english-no-swears.txt')
    random_line = rand(lines.length)
    lines[random_line..-1].each do |word|
      word = word.strip  # Remove leading/trailing whitespaces
      next if word.length < 5 || word.length > 12
      return random_word = word
    end
  end

  def display()
    puts "#{@hidden_word} | Lives: #{@lives} | Used letters: #{@used_letters}"
    puts "\n"
  end

  def set_blank_word(secret_word)
    hidden_word = secret_word.chars.map { |v| "_" }
    hidden_word.join
  end

  def used_letter?(letter)
    if @used_letters.include?(letter)
      puts "Letter already used, try another one."
      return true
    else
      return false
    end
  end

  def try_word(letter)
    one_hit = false

    hidden_word = @secret_word.chars.map.with_index do |element, index|
      #puts(" v=#{v} letter=#{letter}")
      if element == letter
        #puts "Y"
        one_hit = true
        letter
      else
        #puts "N"
        @hidden_word[index]
      end
    end

    @hidden_word = hidden_word.join()

    if one_hit
      @used_letters.push(letter)
      return true
    else
      puts "Wrong letter!"
      @used_letters.push(letter)
      @lives -= 1
      return false
    end

  end

end


class Player

  def make_guess(gallows)
    puts "Give a letter: "
    try = gets.downcase.chomp
    puts "\n"

    puts try.length
    while try.length != 1
      puts "Invalid input."
      make_guess(gallows)
    end
    if gallows.used_letter?(try)
      make_guess(gallows)
    else
      gallows.try_word(try)
    end
  end

end

class Hangman

  def initialize()
    @gallows = Gallows.new
    @player = Player.new
  end

  def end_game()
    puts "Do you want to play again?(Y/N)"
    choice = gets.chomp.downcase
    case choice
    when "y"
      @gallows = Gallows.new
      @player = Player.new
      menu()
    when "n"
      exit(0)
    else
      puts "Invalid option"
      endgame()
    end
  end

  def check_winner()

    if @gallows.lives == 0
      puts "Gallows won"
      endgame()
    elsif @gallows.hidden_word == @gallows.secret_word
      puts "Player won"
      endgame()
    end

  end

  def menu()
    @player.make_guess(@gallows) #retorna true or false line, mesmo retorno de try word
    @gallows.display()

    check_winner()

    menu()
  end

end

Hangman.new.menu
