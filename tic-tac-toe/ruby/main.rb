require_relative './lib/player'
require_relative './lib/board'
require_relative './lib/game'


player1 = Player.get_player_input('O')
player2 = Player.get_player_input(player1.marker)

game = Game.new(player1, player2)
game.start