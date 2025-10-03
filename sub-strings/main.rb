list = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, dict)
  sanitized_words = string.downcase.gsub(/[^a-z\s]/, '').split

  matches = []

  sanitized_words.each do |item|
    dict.each do |word|
      matches << word if item.include?(word)
    end
  end

  matches.tally
end

puts substrings("Howdy partner, sit down! How's it going?", list)
