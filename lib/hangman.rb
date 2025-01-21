require 'yaml'

dict = "google-10000-english-no-swears.txt"
max_tries = 12

def load_dict(file)
  File.readlines(file).map(&:chomp)
end

def filter_words(words)
  words.reject { |word| word.length < 5 || word.length > 12 }
end

def check_all_occurrences(letter, word)
  word.each_index.select { |i| word[i] == letter }
end

def save_game(state)
  File.open("saved_game.yml", "w") { |file| file.write(state.to_yaml) }
end

def load_game
  return nil unless File.exist?("saved_game.yml")
  YAML.load_file("saved_game.yml")
end

def start_game(dict)
  all_words = load_dict(dict)
  match_words = filter_words(all_words)
  secret_word = match_words.sample.split('')
  guessed_word = Array.new(secret_word.length, "_")
  { secret_word: secret_word, guessed_word: guessed_word, tries: 0 }
end

puts "Welcome to Hangman!"
puts "Would you like to load a saved game? (y/n)"
load_choice = gets.chomp.downcase

if load_choice == 'y'
  game_state = load_game
  if game_state
    puts "Loaded saved game."
  else
    puts "No saved game found. Starting a new game."
    game_state = start_game(dict)
  end
else
  game_state = start_game(dict)
end

secret_word, guessed_word, tries = game_state.values

puts "The secret word has #{secret_word.length} letters."
print "#{guessed_word.join(' ')}\n"

loop do
  puts "Enter a letter or type 'save' to save: "
  letter = gets.chomp.downcase

  if letter == 'save'
    game_state[:tries] = tries  # Ensure we save the current number of tries
    save_game(game_state)
    puts "Game saved!"
    break
  end

  if letter.length == 1 && letter.match(/[a-z]/)
    if secret_word.include?(letter)
      check_all_occurrences(letter, secret_word).each { |i| guessed_word[i] = letter }
      print "#{guessed_word.join(' ')}\n"
    else
      puts "Wrong letter."
    end
  elsif !letter.match(/[a-z]/)
    redo
  else
    puts "Please enter only one letter."
  end

  if guessed_word == secret_word
    puts "You won!"
    break
  elsif tries >= max_tries
    puts "Game over! The secret word was '#{secret_word.join}'"
    break
  else
    puts "Tries remaining: #{max_tries - tries}"
  end

  tries += 1
end
