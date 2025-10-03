require_relative '../lib/caesar_encrypt'

describe CaesarEncrypt do
  subject(:cipher) { described_class.new('hello', 2) }

  context 'when checking the alphabet array' do
    it 'has "a" as the first letter' do
      expect(cipher.alphabet.first).to eq('a')
    end

    it 'has "z" as the last letter' do
      expect(cipher.alphabet.last).to eq('z')
    end

    it 'contains 26 letters' do
      expect(cipher.alphabet.size).to eq(26)
    end
  end

  context 'when encrypting a message' do
    
    it 'shifts "a" by 2 places to "c"' do
      cipher = described_class.new('a', 2)
      expect(cipher.encrypt).to eq('c')
    end

    it 'shifts "hello" by 2 places to "jgnnq"' do
      expect(cipher.encrypt).to eq('jgnnq')
    end

    it 'keeps uppercase letters' do
      cipher = described_class.new('Hello', 2)
      expect(cipher.encrypt).to eq('Jgnnq')
    end

    it 'ignores non-alphabetic characters' do
      cipher = described_class.new('Hello, World!', 2)
      expect(cipher.encrypt).to eq('Jgnnq, Yqtnf!')
    end

    it 'correctly wraps from "z" to "a"' do
      cipher = described_class.new('xyz', 3)
      expect(cipher.encrypt).to eq('abc')
    end
  end

  context 'when handling edge cases' do
    it 'does not change non-letter characters' do
      cipher = described_class.new('123!@#', 5)
      expect(cipher.encrypt).to eq('123!@#')
    end

    it 'does not modify an empty string' do
      cipher = described_class.new('', 3)
      expect(cipher.encrypt).to eq('')
    end
  end
end