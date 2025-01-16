require_relative 'codebreaker'

class CodeMaker < CodeBreaker
  include CompareCodes

  def initialize
    @all_combinations = COLORS.repeated_permutation(4).to_a
    @first_guess = ['Red', 'Red', 'Blue', 'Blue']
    @tries = 0
    puts "\nEnter the secret code (choose 4 colors from: #{COLORS.join(', ')}):"
    @secret_code = gets.chomp.split.map(&:capitalize)
    unless @secret_code.all? { |color| COLORS.include?(color) } && @secret_code.length == 4
      raise 'Invalid input. Please enter exactly 4 valid colors.'
    end
  end

  def start_game
    puts "\tWelcome to Mastermind! Try to guess the secret code."
    puts "You can choose from: #{COLORS.join(', ')}"
    knuth
  end

  private

  def knuth
    until @tries >= 12
      puts "\nIteration #{@tries + 1}"
      feedback = compare_codes(@secret_code, @first_guess)
      puts "Feedback for guess #{@first_guess}: black_pegs - #{feedback[0]} white_pegs - #{feedback[1]}"

      @all_combinations.reject! do |possible_code|
        feedback_for_possible_code = compare_codes(possible_code, @first_guess)
        feedback_for_possible_code != feedback
      end

      puts "Remaining combinations: #{@all_combinations.size}"
      
      if @all_combinations.empty?
        puts "No valid combinations left. Game over!"
        break
      end

      break if @all_combinations.length == 1 && @all_combinations.first == @secret_code

      @first_guess = @all_combinations.sample
      @tries += 1
    end

    if @all_combinations.length == 1 && @all_combinations.first == @secret_code
      puts "\nSuccess! The secret code is #{@first_guess}."
    else
      puts "Game over! You used all attempts without guessing the code."
    end

    print "Remaining possible code combinations: #{@all_combinations}\n"
  end
end

comp_game = CodeMaker.new
comp_game.start_game
