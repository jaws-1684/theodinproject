require_relative './lib/game'

def get_name
  loop do
    name = gets.chomp.strip  

    if name.empty?
      print "Enter a valid name: "
    else
      return name  
    end
  end
end

def get_color
  loop do
    begin
      color = Integer(gets.chomp)  
      if color.between?(1, 2)  
        return color 
      else
        print "Enter a valid value (1 or 2): "
      end
    rescue ArgumentError 
      print "Invalid input! Please enter a number (1 or 2)."
    end
  end
end

puts "\n\t\t*** Welcome to Connect Four ***\n\n"
print "Enter first player's name: "
name1 = get_name
print "First player can choose a color(enter 1 for red and 2 for yellow): "
p1_color = get_color
print "Enter second player's name: "
name2 = get_name

color1 = p1_color == 1 ? RED : YELLOW
color2 = color1 == RED ? YELLOW : RED

player1 = Player.new(name1, color1)
player2 = Player.new(name2, color2)
game = Game.new(player1, player2)

loop do
	game.start
	puts "#{game.current_player.name}'s move. Enter a position for a #{game.current_player.color} piece."
	pos = gets.chomp.to_i
	game.player_move(pos)
	
	if game.game_over?
		game.board.draw
		break
	end
end

