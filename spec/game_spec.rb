require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  let(:player1) { Player.new('Player 1', RED) }
  let(:player2) { Player.new('Player 2', YELLOW) }
  let(:game) { Game.new(player1, player2) }

  describe '#initialize' do
    it 'initializes with two players and a board' do
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
      expect(game.board).to be_a(Board)
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#switch_player' do
    it 'switches current player from player1 to player2' do
      game.switch_player
      expect(game.current_player).to eq(player2)
    end

    it 'switches back to player1 after two switches' do
      2.times { game.switch_player }
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#player_move' do
    it 'adds the current player\'s piece to the specified column' do
      allow(game.board).to receive(:add)
      expect(game.board).to receive(:add).with(3, player1.color)
      game.player_move(3)
    end
  end

  describe '#game_over?' do
    context 'when there is a horizontal win in the first row' do
      before do
        game.board.cells[0] = [RED, RED, RED, RED, nil, nil, nil]
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is a horizontal win starting at position 1 in row 0' do
      before do
        game.board.cells[0] = [nil, RED, RED, RED, RED, nil, nil]
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is no horizontal win' do
      before do
        game.board.cells[0] = [RED, RED, RED, YELLOW, nil, nil, nil]
      end

      it 'returns false' do
        expect(game.game_over?).to be false
      end
    end

    context 'when a horizontal win exists in another row' do
      before do
        game.board.cells[1] = [YELLOW, YELLOW, YELLOW, YELLOW, nil, nil, nil]
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is a vertical win' do
      before do
        game.board.cells[0] = [RED, nil, nil, nil, nil, nil, nil]
        game.board.cells[1] = [RED, nil, nil, nil, nil, nil, nil]
        game.board.cells[2] = [RED, nil, nil, nil, nil, nil, nil]
        game.board.cells[3] = [RED, nil, nil, nil, nil, nil, nil]
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is a positive diagonal win' do
      before do
        game.board.cells[0][0] = RED
        game.board.cells[1][1] = RED
        game.board.cells[2][2] = RED
        game.board.cells[3][3] = RED
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end


    context 'when there is a negative diagonal win' do
      before do
        game.board.cells[0][3] = RED
        game.board.cells[1][2] = RED
        game.board.cells[2][1] = RED
        game.board.cells[3][0] = RED
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is a tie' do
      before do
        (0..5).each do |row|
          (0..6).each do |col|
            game.board.cells[row][col] = (row + col).even? ? RED : YELLOW
          end
        end
      end

      it 'recognizes a tie' do
        expect(game.tie?).to be true
      end
    end
  end
  
  describe '#start' do
    it 'draws the board' do
      allow(game.board).to receive(:draw)
      expect(game.board).to receive(:draw)
      game.start
    end
  end
end