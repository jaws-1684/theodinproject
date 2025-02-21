class Board
  attr_reader :cells

  def initialize
    @cells = (1..9).to_a
  end

  def draw
    puts "\n"
    puts "\t     |     |"
    puts "\t  #{@cells[0]}  |  #{@cells[1]}  |  #{@cells[2]}"
    puts "\t_____|_____|_____"

    puts "\t     |     |"
    puts "\t  #{@cells[3]}  |  #{@cells[4]}  |  #{@cells[5]}"
    puts "\t_____|_____|_____"

    puts "\t     |     |"
    puts "\t  #{@cells[6]}  |  #{@cells[7]}  |  #{@cells[8]}"
    puts "\t     |     |"
    puts "\n"
  end

  def valid_move?(position)
    position.between?(1, 9) && @cells[position - 1].is_a?(Integer)
  end

  def place_marker(position, marker)
    return false unless valid_move?(position)

    @cells[position - 1] = marker
    true
  end

  def full?
    @cells.none? { |cell| cell.is_a?(Integer) }
  end
end


 