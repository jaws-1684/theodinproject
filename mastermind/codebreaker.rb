module CompareCodes
  def compare_codes(secret_code, guessed_code)
    black_pegs = 0
    white_pegs = 0

    guessed_code.each_with_index do |color, index|
      if color == secret_code[index]
        black_pegs += 1
      end
    end

    guessed_code.each_with_index do |color, guess_index|
      next if guessed_code[guess_index] == secret_code[guess_index]

      if secret_code.include?(color)
        white_pegs += 1
      end
    end

    [black_pegs, white_pegs]
  end
end


class CodeBreaker
	COLORS = ['Red', 'Blue', 'Green', 'Yellow', 'Orange', 'Purple']

	def initialize
    @secret_code = 4.times.map { COLORS.sample }
    @max_guesses = 12
    @guesses = 0
  end
  
  def start_game
    puts "\tWelcome to Mastermind! Try to guess the secret code."
    puts "You can choose from: #{COLORS.join(', ')}"
  
    until @guesses >= @max_guesses
      print "Enter your guess (4 colors separated by spaces): "
      guessed_code = gets.chomp.split.map(&:capitalize)
  
      if invalid_guess?(guessed_code)
        puts "Your code contains invalid colors or is not the correct length! Please enter 4 valid colors."
        next
      end
  
      black_pegs, white_pegs = compare_codes(@secret_code, guessed_code)
  
      puts "You have #{black_pegs} color(s) in the correct position and #{white_pegs} correct color(s) in the wrong position."
  
      if black_pegs == 4
        puts "Congratulations! You've guessed the secret code: #{@secret_code.join(', ')}"
        break
      end
  
      @guesses += 1
    end
  
    if @guesses >= @max_guesses
      puts "Game Over! The secret code was: #{@secret_code.join(', ')}"
    end
  end

  private

  def invalid_guess?(guessed_code)
    guessed_code.size != 4 || !guessed_code.all? { |code| COLORS.include?(code) }
  end	

  include CompareCodes
end	


