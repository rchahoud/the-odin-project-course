# This project is not finalized

# Falta incluir a inteligencia do cpu como code breaker
class Board
  attr_accessor :rows
  COLORS = %w[red green blue yellow purple pink]
  def initialize
    @rows = []
    12.times do |v|
      @rows.append([Array.new(4, " "), Array.new(4, " ")])
    end
  end
  def display(round)
    puts "         Guess        |     Accuracy"
    puts "             ----- Round: #{round} ------"
    @rows.each do |v|
      p v
    end
  end
  def modify_board(play, round, table_side)
    position = round - 1
    @rows[round-1][table_side] = play
  end
end

module CodeMaker
  attr_accessor :secret_code
  def code_breaker_winner?(play)
    if @secret_code == play
      puts "Code breaker won"
      return true
    end
  end
  def code_maker_winner?(round)
    if round > 12
      puts "Code maker won"
      return true
    end
  end
end

class CpuCodeMaker
  include CodeMaker
  def initialize()
    @secret_code = [Board::COLORS[rand(6)], Board::COLORS[rand(6)], Board::COLORS[rand(6)], Board::COLORS[rand(6)]]
    puts "Secret code: #{@secret_code}"
  end
  def check_accuracy(play, board, round)
    play.each_with_index do |v, i|
      if v == @secret_code[i]
        # Colocar a função modify board ao invés de utilizar a variável diretamente
        board.rows[round-1][1][i] = "black"
      elsif @secret_code.include?(v) && v != @secret_code[i]
        board.rows[round-1][1][i] = "white"
      end
    end
  end
end

class PlayerCodeMaker
  include CodeMaker
  def initialize()
    while true
      puts "Select the secret code [color1] [color2] [color3] [color4]"
      input = gets.chomp.split
      if input.length() == 4 && Board::COLORS.include?(input[0]) && Board::COLORS.include?(input[1]) && Board::COLORS.include?(input[2]) && Board::COLORS.include?(input[3])
        @secret_code = input
        break
      end
    end
  end
  def check_accuracy(play, board, round)
    while true
      puts "select the accuracy [color1] [color2] [color3] [color4]"
      input = gets.split.map(&:downcase)
      puts "input lenght #{input.length()}"
      if input.length() == 4 && input.all? { |v| ["black", "white", "."].include?(v) }
        puts "i am here"
        board.modify_board(input, round, 1)
        break
      end
    end
  end
end

class CpuCodeBreaker
  attr_accessor :help_buffer
  def initialize
    @help_buffer = ["", "","",""]
  end
  def check_help_buffer
    @help_buffer = board.rows[round-2][1].map{ |v| v == "black" ? "black" : ""}
  end

  def make_guess(board, round)
    puts "CPU will make a guess"
    guess = [Board::COLORS[rand(6)],Board::COLORS[rand(6)], Board::COLORS[rand(6)], Board::COLORS[rand(6)]]
    board.modify_board(guess, round, 0)
  end
end

class PlayerCodeBreaker
  def make_guess(board, round)
    while true
      puts "Do your play: [color1] [color2] [color3] [color4]"
      play = gets.split.map(&:downcase)
      puts "\n"
      # Falta checar as cores nesse if
      if play.length == 4
        board.modify_board(play, round, 0)
        return play
      end
    end
  end
end

class Game
  attr_accessor :round
  def initialize()
    @board = Board.new
    @round = 1
  end
  def start_game()
    puts "Do you want to be the code breaker or maker?(B/M)"
    while true
      input = gets.chomp.downcase
      if input == "b"
        @code_maker = CpuCodeMaker.new
        @code_breaker = PlayerCodeBreaker.new
        menu()
      elsif input == "m"
        @code_maker = PlayerCodeMaker.new
        @code_breaker = CpuCodeBreaker.new
        menu()
      end
    end
  end
  def end_game()
    puts "Do you want to restart the game?(Y/N)"
    input = gets.chomp().downcase()
    if input == "y"
      @board = Board.new
      @round = 1
      start_game()
    elsif input == "n"
      puts "Ending the game"
      exit(0)
    else
      puts "Invalid input."
      end_game()
    end
  end
  def menu()
    @code_maker.code_maker_winner?(round) ? end_game() : nil

    play = @code_breaker.make_guess(@board, @round)
    puts "*The play is #{play}"

    @code_maker.code_breaker_winner?(play) ? end_game() : nil
    @code_maker.check_accuracy(play, @board, @round)


    @board.display(@round)
    @round += 1
    menu()
  end
end

Game.new.start_game
