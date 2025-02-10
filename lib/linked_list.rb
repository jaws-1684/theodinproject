require_relative "node"

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size
  	count = 0 
  	current = @head
  	loop do 
  		break if current.nil?

  		count += 1
  		current = current.next_node
  	end
  	count
  end	

  def head
  	@head
  end	

  def tail
  	@tail
  end

	def at(index)
  	i = 0
  	current = @head

  	loop do
  		return current if i == index

  		current = current.next_node
  		i+=1
  	end
  	nil
  end

  def pop 
  	current = @head
  	while current.next_node != @tail
  		current = current.next_node
  	end
  	
  	current.next_node = nil
  	@tail = current	
  end

  def contains?(value)
  	current = @head

  	loop do 
  		return false if current.nil? 
  		return true if current.value == value

  		current = current.next_node
  	end
  end
  
  def find(value)
  	current = @head
  	i = 0 
  	loop do
  		break if current.next_node.nil?
  		return i if current.value == value
  		
  		current = current.next_node
  		i += 1
  	end
  	nil	
 	end 		

  def to_s
  	current = @head
  	str = ''

  	loop do 
  		break if current.next_node.nil?
  			str += "( #{current.value} ) -> "
  			current = current.next_node
  	end
  	str + "nil"	 
  end

  def insert_at(value, index)
  	prev_node = at(index - 1)

  	new_node = Node.new(value, prev_node.next_node)
  	prev_node.next_node = new_node
    @tail = new_node if new_node.next_node.nil?
  end	

  def remove_at(index, i=0)
		prev_node = at(index - 1)
		current_node = prev_node.next_node
		prev_node.next_node = current_node.next_node
    @tail = prev_node if current_node == @tail
	end
end


