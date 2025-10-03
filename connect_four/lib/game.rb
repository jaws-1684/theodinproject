require_relative 'board'
require_relative 'player'


RED = "\e[31m\u25CF\e[0m"
YELLOW = "\e[33m\u25CF\e[0m"
PIECES = [RED, YELLOW]


class Game
	attr_reader :board
	attr_accessor :player1, :player2, :current_player

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@board = Board.new
		@current_player = @player1
	end

	def start
		@board.draw
	end

	def player_move(pos)
		@board.add(pos, current_player.color)
		
		if not winner? 
			switch_player
		end
	end

	def switch_player
		@current_player = @current_player == @player1 ? @player2 : @player1
	end

	def game_over?
		if winner?
    	puts "#{current_player.name} won!"
    	true
  	elsif tie?  # Fixed syntax (changed `else tie?` to `elsif tie?`)
    	puts "It's a tie!"
    	true
 		else
    	false
  	end
	end

	def winner?(row = 0, col = 0)
  
  	return false if row > 5  
  	return true if check_horizontals(row, col) || 
                 check_verticals(row, col) || 
                 check_positive_diagonals(row, col) || 
                 check_negative_diagonals(row, col)

  	col < 6 ? winner?(row, col + 1) : winner?(row + 1, 0)
	end

	def tie?
		return true if @board.full?
	end

	private

	def check_horizontals(row, col)
  	return false if col > 3 
  	PIECES.each do |piece|
    	return true if @board.cells[row][col, 4] == [piece] * 4
  	end
  	false  
	end

	def check_verticals(row, col) 
		return false if row > 2

		PIECES.each do |piece|
			return true if (0..3).all? {|i| @board.cells[row+i][col] == piece}
		end

		false
	end

	def check_positive_diagonals(row, col)
  	return false if row > 2 || col > 3 
  		PIECES.each do |piece|
    		return true if (0..3).all? { |i| @board.cells[row + i][col + i] == piece }
  		end
  	false
	end

	def check_negative_diagonals(row, col)
  	return false if row > 2 || col < 3  
  	PIECES.each do |piece|
    	return true if (0..3).all? { |i| @board.cells[row + i][col - i] == piece }
  	end
  	false
	end
	

end

