require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  let(:player1) { Player.new('Alice', 'X') }
  let(:player2) { Player.new('Bob', 'O') }
  let(:board) { Board.new }

  describe '#initialize' do
    it 'assigns a name and marker to the player' do
      expect(player1.name).to eq('Alice')
      expect(player1.marker).to eq('X')
    end
  end

  describe '#winner?' do
    it 'returns true if the player wins' do
      board.place_marker(1, 'X')
      board.place_marker(2, 'X')
      board.place_marker(3, 'X')

      expect(player1.winner?(board)).to be true
    end

    it 'returns false if the player does not win' do
      board.place_marker(1, 'X')
      board.place_marker(2, 'O')
      board.place_marker(3, 'X')

      expect(player1.winner?(board)).to be false
    end
  end
end
