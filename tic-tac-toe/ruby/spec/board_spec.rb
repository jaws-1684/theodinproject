require_relative '../lib/board.rb'

describe Board do
  subject(:board) { described_class.new }

    describe '#initialize' do
      context 'when creating a new board' do
        it 'initializes with numbered cells 1-9' do
        expect(board.cells).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
        end
      end    
    end  

  describe '#valid_move?' do
      context 'when position is available' do
        it 'returns true for valid position' do
          expect(board.valid_move?(5)).to be true
        end
      end

      context 'when position is taken' do
        before { board.place_marker(5, 'X') }
        
        it 'returns false' do
          expect(board.valid_move?(5)).to be false
        end
      end

      context 'when position is out of bounds' do
        it 'returns false for 0' do
          expect(board.valid_move?(0)).to be false
        end

        it 'returns false for 10' do
          expect(board.valid_move?(10)).to be false
        end
      end
    end  

  describe '#full?' do
      context 'when board has empty spaces' do
        it 'returns false' do
          expect(board.full?).to be false
        end
      end

      context 'when board is completely filled' do
        before do
          (1..9).each { |pos| board.place_marker(pos, pos.odd? ? 'X' : 'O') }
        end

        it 'returns true' do
          expect(board.full?).to be true
        end
      end
    end  
end  
