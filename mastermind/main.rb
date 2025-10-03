require_relative 'codebreaker'
require_relative 'codemaker'

puts "You wanna be the code breaker or the code maker? (choose 1 for breaker and 2 for maker)"
answer = gets.chomp.to_i

if answer == 1
  game = CodeBreaker.new
  game.start_game
elsif answer == 2
  game = CodeMaker.new
  game.start_game
else
  puts "Invalid option. Please choose 1 for code breaker or 2 for code maker."
end
