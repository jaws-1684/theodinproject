require_relative './lib/caesar_encrypt'
require_relative './lib/caesar_decrypt'


# phrase = CaesarEncrypt.get_valid_message('Enter your message: ')
# choice = CaesarEncrypt.select_cipher_mode('Enter 1 to encipher or 2 to decipher', 1..2)
# shift = CaesarEncrypt.select_cipher_mode('Enter the shift value (1-26)', 1..26)

# cipher = choice == 1 ? CaesarEncrypt.new(phrase, shift) : CaesarDecrypt.new(phrase, shift)
# puts "Result: #{cipher.send(choice == 1 ? :encrypt : :decrypt)}"

# def code_breaker(encrypted_message, shift = 1)
#   return [] if shift > 26 # Base case: stop recursion when shift exceeds 26

#   decrypted_text = CaesarDecrypt.new(encrypted_message, shift).decrypt
#   [decrypted_text] + code_breaker(encrypted_message, shift + 1) # Collect results
# end
# puts code_breaker('')