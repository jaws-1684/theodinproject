class Board
  attr_reader :cells

  def initialize
    @cells = Array.new(6) { Array.new(7) }
  end

  def draw
    puts "\n"
    puts "\t   1  |  2  |  3  |  4  |  5  |  6  |  7 "
    puts "\t-------------------------------------------"
    
    @cells.reverse.each do |row|
      puts "\t|  #{row[0] || ' '}  |  #{row[1] || ' '}  |  #{row[2] || ' '}  |  #{row[3] || ' '}  |  #{row[4] || ' '}  |  #{row[5] || ' '}  |  #{row[6] || ' '}  |"
      puts "\t-------------------------------------------"
    end
    puts "\n"
  end

  def add(pos, color)
    row = valid_move?(pos)
    return if row.nil?

    @cells[row][pos-1] = color 
  end

  def full?
    @cells.all? { |row| row.none?(&:nil?) }
  end

  private

  def valid_move?(pos, row=0)
    return nil unless pos.between?(1, 7)
    
    if @cells[row][pos-1].nil?
      row
    elsif row < 5 
      valid_move?(pos, row+1)
    else
      nil
    end
  end
end

# board = Board.new
# board.add(5, "\e[31m\u25CF\e[0m")
# board.add(5, "\e[33m\u25CF\e[0m")
# board.add(5, "\e[33m\u25CF\e[0m")
# board.add(5, "\e[33m\u25CF\e[0m")
# board.draw

