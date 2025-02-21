require_relative 'board'

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def winner?(board)
    win_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
      [0, 4, 8], [2, 4, 6]             # Diagonals
    ]

    win_combinations.any? do |combo|
      values = board.cells.values_at(*combo)
      values.uniq.size == 1 && values.first == @marker
    end
  end

   def self.get_player_input(other_player_marker)
    puts "Enter your name:"
    name = gets.chomp
    loop do
      puts "Enter your marker (X or O):"
      marker = gets.chomp.upcase
      if marker != other_player_marker
        return Player.new(name, marker)
      else
        puts "Marker #{marker} is already taken. Please choose a different one."
      end
    end
  end

  def get_move
    puts "#{@name} (#{@marker}), enter position (1-9, 0 to quit):"
    input = gets.chomp.to_i
    input
  end
end

