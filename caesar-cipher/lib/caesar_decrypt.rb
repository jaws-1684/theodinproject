class CaesarDecrypt < CaesarEncrypt
  def decrypt
    @direction = -1  # Reverse direction for decryption
    encrypt 
  end
end

