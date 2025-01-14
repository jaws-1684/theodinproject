class Board
  attr_accessor :board

  def initialize
    @board = (1..9).to_a 
  end

  def draw_board
    puts "\n"
    puts "\t     |     |"
    puts "\t  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}"
    puts "\t_____|_____|_____"

    puts "\t     |     |"
    puts "\t  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}"
    puts "\t_____|_____|_____"

    puts "\t     |     |"
    puts "\t  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}"
    puts "\t     |     |"
    puts "\n"
  end
end

class Game < Board
  attr_accessor :current_player

  def initialize
    super()
    @current_player = "X"
  end

  def check_win
    win_combination = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], 
      [0, 3, 6], [1, 4, 7], [2, 5, 8], 
      [0, 4, 8], [2, 4, 6]             
    ]

    win_combination.each do |pos|
      if @board[pos[0]] == @board[pos[1]] &&
         @board[pos[1]] == @board[pos[2]] &&
         %w[X O].include?(@board[pos[0]])
        return @board[pos[0]]
      end
    end
    nil 
  end

  def game_step(index, char)
    if index < 1 || index > 9 || %w[X O].include?(@board[index - 1])
      false 
    else
      @board[index - 1] = char
      true 
    end
  end

  def start_game
    step = 1

    draw_board

    while step <= 9 && check_win.nil?
      puts "Player #{@current_player}'s turn. Enter the field number (1-9, 0 to exit):"
      index = gets.chomp.to_i

      if index == 0
        puts "Game exited."
        break
      end

      if game_step(index, @current_player)
        puts "Successful move!"

       
        @current_player = @current_player == "X" ? "O" : "X"

        draw_board
        step += 1
      else
        puts "Invalid move! Try again."
      end
    end

    if (winner = check_win)
      puts "#{winner} won!"
    elsif step > 9
      puts "Game over. It's a draw!"
    end
  end
end

game = Game.new
game.start_game
