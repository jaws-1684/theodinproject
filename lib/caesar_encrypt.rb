class CaesarEncrypt
  attr_reader :message, :shift, :direction

  def initialize(message, shift, direction = 1)
    @message = message
    @shift = shift
    @direction = direction
  end

  def alphabet
    ('a'..'z').to_a
  end

  def encrypt
    @message.chars.map { |char| shift_character(char) }.join
  end

  def self.get_valid_message(prompt)
  	loop do 
  		print "#{prompt}"

  		input = gets.chomp
  		return input if not input.empty?

  		puts 'Message cannot be empty.'
  	end
  end	

  def self.select_cipher_mode(prompt, range)
  	loop do
    	print "#{prompt}: "
    	input = gets.chomp

    	return input.to_i if input.match?(/\A\d+\z/) && range.include?(input.to_i)
    	puts "Invalid input. Please enter a number between #{range.first} and #{range.last}."
  	end
	end

  private

  def shift_character(char)
    letters = alphabet

    if letters.include?(char.downcase)
      idx = letters.index(char.downcase)
      new_idx = (idx + @shift * @direction) % letters.length
      new_char = letters[new_idx]
      char == char.upcase ? new_char.upcase : new_char
    else
      char
    end
  end
end

