class HashMap
	attr_reader :size

	def initialize (load_factor = 0.75, initial_capacity = 16)
		@load_factor = load_factor
		@capacity = initial_capacity
		@buckets = Array.new(initial_capacity) { [] }
		@size = 0
	end
	
	def hash(key)	
   hash_code = 0
   prime_number = 31
      
   key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
      
   hash_code
 end

 def set(key, value)

 	index = hash(key) % @capacity
 	bucket = @buckets[index]

 	entry = bucket.find {|e| e[0] == key}

 	if entry 
 		entry[1] = value
 	else
 		bucket << [key, value]
 		@size += 1

 		resize if @size.to_f / @capacity > @load_factor
 	end		
 end

 def get(key)
 	index = hash(key) % @capacity
 	bucket @buckets[index]

 	entry = bucket.find {|e| e[0] == key}
 	entry ? entry[1] : nil
 end

 def has?(key)
 	index = hash(key) % @capacity
  @buckets[index].any? { |e| e[0] == key }
 end

 def remove(key)
  index = hash(key) % @capacity
  bucket = @buckets[index]
  entry_index = bucket.index { |e| e[0] == key }

  if entry_index
    entry = bucket.delete_at(entry_index)
    @size -= 1
    entry[1]
  else
    nil
  end
	end

	def length
		@size
	end

	def clear
		@buckets.each(&:clear)
		@size = 0
	end

	def keys
		@buckets.flat_map { |bucket| bucket.map { |e| e[0] } }
	end	

	def values
		@buckets.flat_map { |bucket| bucket.map { |e| e[1] } }
	end

	def entries
    @buckets.flat_map { |bucket| bucket.map { |e| [e[0], e[1]] } }
	end

	private

	def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      	bucket.each do |key, value|
        	set(key, value)
      	end
    end
  end
end