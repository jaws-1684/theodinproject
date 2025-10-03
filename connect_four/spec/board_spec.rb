require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }
  let(:red) {'red'}
  let(:yellow) {'yellow'}

  describe '#initialize' do
    it 'creates a 6x7 grid of empty cells' do
      expect(board.cells.size).to eq(6)
      expect(board.cells.all? { |row| row.size == 7 }).to be true
      expect(board.cells.flatten.all?(&:nil?)).to be true
    end
  end

  describe '#add' do
    context 'when adding to empty column' do
      it 'places piece at bottom' do
        board.add(1, :red)
        expect(board.cells[0][0]).to eq(:red)
      end
    end

    context 'when stacking pieces' do
      before { 2.times { board.add(5, :yellow) } }
      
      it 'places new piece on top' do
        board.add(5, :red)
        expect(board.cells[2][4]).to eq(:red)
      end
    end

    context 'when column is full' do
      before { 6.times { board.add(7, :red) } }
      
      it 'does not add piece' do
        expect { board.add(7, :red) }.not_to change { board.cells.flatten.compact.size }
      end
    end

    context 'with invalid column' do
      it 'does not add piece' do
        expect { board.add(0, :red) }.not_to change { board.cells.flatten.compact }
        expect { board.add(8, :red) }.not_to change { board.cells.flatten.compact }
      end
    end
  end

  describe 'vertical stacking' do
    it 'stacks pieces correctly' do
      colors = [:red, :yellow, :red, :yellow]
      colors.each { |color| board.add(3, color) }

      expect(board.cells[0][2]).to eq(:red)
      expect(board.cells[1][2]).to eq(:yellow)
      expect(board.cells[2][2]).to eq(:red)
      expect(board.cells[3][2]).to eq(:yellow)
      expect(board.cells[4][2]).to be_nil
    end
  end

  describe 'multiple columns' do
    it 'maintains separate columns' do
      board.add(1, :red)
      board.add(7, :yellow)
      board.add(4, :red)

      expect(board.cells[0][0]).to eq(:red)
      expect(board.cells[0][6]).to eq(:yellow)
      expect(board.cells[0][3]).to eq(:red)
    end
  end
end