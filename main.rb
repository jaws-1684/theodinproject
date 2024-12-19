def caesar_cipher(str, n, direction = 1)
  letters = ("a".."z").to_a
  str.chars.map do |char|
    if letters.include?(char.downcase)
      idx = letters.index(char.downcase)
      new_idx = (idx + n * direction) % letters.length
      new_char = letters[new_idx]
      char == char.upcase ? new_char.upcase : new_char
    else
      char
    end
  end.join
end

puts "Enter 1 to encipher or 2 to decipher:"
choice = gets.chomp.to_i

puts "Enter a phrase:"
phrase = gets.chomp

puts "Enter the shift value (numeric):"
shift = gets.chomp.to_i

if choice == 1
  puts "Result: #{caesar_cipher(phrase, shift, 1)}"
else
  puts "Result: #{caesar_cipher(phrase, shift, -1)}" 
end
