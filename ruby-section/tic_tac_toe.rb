class Table
  attr_accessor :table, :winner, :round
  def initialize()
      @table = [[" ", " ", " "],
                [" ", " ", " "],
                [" ", " ", " "]]
			@round = 1
			@winner = 0
  end
  def print_table()
		puts "------Round: #{@round}------"
    @table.each do |v|
			p v
		end
  end
	def free_position?(row, column)
		begin
			if @table[row][column] == " "
				return true
			else
				puts "Invalid position. Do your play again."
				return false
			end
		rescue
			puts "Invalid position. Do your play again."
			return false
		end
	end
	def mark(row, column, symbol)
		@table[row][column] = symbol
		print_table()
		@round += 1
	end
	def check_winner(symbol)
		#TE AMO BEM GRANDE assinado sua namorada

		#check each row of the table for the winner
		@table.each do |v|
			if v[0] == symbol && v[1] == symbol && v[2] == symbol
				return true
			end
		end

		#check each column of the table for the winner
		if @table[0][0] == symbol && @table[1][0] == symbol && @table[2][0] == symbol
			return true
		end
		if @table[0][1] == symbol && @table[1][1] == symbol && @table[2][1] == symbol
			return true
		end
		if @table[0][2] == symbol && @table[1][2] == symbol && @table[2][2] == symbol
			return true
		end

		#check the diagonal of the table for the winner
		if @table[0][0] == symbol && @table[1][1] == symbol && @table[2][2] == symbol
			return true
		end
		if @table[0][2] == symbol && @table[1][1] == symbol && @table[2][0] == symbol
			return true
		end

		false
	end

end

class Player
	attr_accessor :symbol
  def initialize(player_number)
		if player_number == 1
      @symbol = "X"
    else
    	@symbol = "O"
    end
  end
  def play(row, column, table)
		if table.free_position?(row, column) == true
			table.mark(row, column, @symbol)
			return true
		else
			return false
		end
  end
end

class Game
	def initialize
		@table = Table.new()
		@player1 = Player.new(1)
		@player2 = Player.new(2)
		@player_round = 1
	end
	def menu()
		puts "Do your play this way: [row] [column]"
		user_input = gets.split.map(&:to_i)
		row = user_input [0] - 1
		column = user_input[1] - 1

		if @player_round == 1
			@player1.play(row, column, @table) ? @player_round = 2 : menu()
		else
			@player2.play(row, column, @table) ? 	@player_round = 1 : menu()
		end

		if @table.check_winner(@player1.symbol)
			puts "Player 1 won!"
			continue?()? initialize_game() : exit(0)
		elsif @table.check_winner(@player2.symbol)
			puts "Player 2 won!"
			continue?() ? initialize_game() : exit(0)
		elsif @table.round == 9
			puts "It's a draw!"
			initialize_game()
			menu()
		else
			menu()
		end
	end
	def initialize_game()
		@table = Table.new
		@player_round = 1
		menu()
	end
	def continue?()
		puts "Do you want to continue?(y/n)"
		input = gets.chomp().downcase()
		puts "You entered: #{input}"

		if input == "y"
			return true
		elsif input == "n"
			return false
		else
			puts "Invalid answer"
			continue?()
		end
	end
end

game = Game.new
game.initialize_game()
