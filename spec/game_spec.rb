require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  let(:player1) { Player.new('Alice', 'X') }
  let(:player2) { Player.new('Bob', 'O') }
  let(:game) { Game.new(player1, player2) }

  describe '#initialize' do
    it 'initializes with a board' do
      expect(game.board).to be_a(Board)
    end

    it 'sets player1 and player2' do
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
    end

    it 'starts with player1 as the current player' do
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#switch_player' do
    it 'switches the current player' do
      game.switch_player
      expect(game.current_player).to eq(player2)

      game.switch_player
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#game_over?' do
    it 'returns true if player1 wins' do
      game.board.place_marker(1, 'X')
      game.board.place_marker(2, 'X')
      game.board.place_marker(3, 'X')
      
      expect(game.game_over?).to be true
    end

    it 'returns true if player2 wins' do
      game.board.place_marker(1, 'O')
      game.board.place_marker(2, 'O')
      game.board.place_marker(3, 'O')
      
      expect(game.game_over?).to be true
    end
  end

  describe '#game_over?' do
    context 'when the board is full and there is no winner (draw)' do
      before do
        (1..9).each { |pos| game.board.place_marker(pos, pos.odd? ? 'X' : 'O') }
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end
  end

  describe '#announce_result' do
    it 'announces the winner if player1 wins' do
      game.board.place_marker(1, 'X')
      game.board.place_marker(2, 'X')
      game.board.place_marker(3, 'X')

      expect(game.announce_result).to eq("Alice (X) won!")
    end

    it 'announces the winner if player2 wins' do
      game.board.place_marker(1, 'O')
      game.board.place_marker(2, 'O')
      game.board.place_marker(3, 'O')

      expect(game.announce_result).to eq("Bob (O) won!")
    end
  end
end
