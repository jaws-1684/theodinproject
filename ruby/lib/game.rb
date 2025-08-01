require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board
  attr_accessor :current_player, :player1, :player2

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def start
    puts "Welcome to Tic Tac Toe!"
    @board.draw

    game_quit = false

    loop do
      position = current_player.get_move
      if position == 0
        game_quit = true
        break
      end

      if @board.place_marker(position, @current_player.marker)
        handle_successful_move
      else
        puts "Invalid move! Try again."
      end

      break if game_over?
    end

    puts game_quit ? "Game has been quit." : announce_result
  end

  def handle_successful_move
    switch_player
    @board.draw
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def game_over?
    @player1.winner?(@board) || @player2.winner?(@board) || @board.full?
  end

  def announce_result
    if @player1.winner?(@board)
      "#{@player1.name} (#{@player1.marker}) won!"
    elsif @player2.winner?(@board)
      "#{@player2.name} (#{@player2.marker}) won!"
    else
       "Game over. It's a draw!"
    end
  end

end
