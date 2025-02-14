class Node
	include Comparable
	attr_accessor :data, :left, :right

	def initialize(data)
		@data = data
		@left = nil
		@right = nil
	end

	def <=>(other)
    @data <=> other.data
  end	

end

class Tree
	attr_accessor :root

	def initialize(array)
		@root = build_tree(array.uniq.sort)
	end

	def build_tree(array)
		return nil if array.empty?

		mid = array.length / 2
		root = Node.new(array[mid])

		root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid+1..-1])
    root
	end	

	def pretty_print(node = @root, prefix = '', is_left = true)
   	pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
   	puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
   	pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
 	end

	def insert(node=@root, value)
  	return Node.new(value) if node.nil?

  	if node.data == value
    	return node
  	end 

  	if value < node.data
    	node.left = insert(node.left, value)
  	elsif value > node.data
    	node.right = insert(node.right, value)
  	end

   	node
	end

	def get_successor(node)
    node = node.right
    node = node.left until node.nil? || node.left.nil?
    node
  end
    
	def delete(node=@root, value)
		return nil if node.nil?

    if node.data > value
        node.left = delete(node.left, value)
    elsif node.data < value
        node.right = delete(node.right, value)
        
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

    	succ = get_successor(node)
      node.data = succ.data
      node.right = delete(node.right, succ.data)
    end    
    node
	end

	def find(value)
		current = @root
		while current
			if value == current.data
				current
			elsif value < current.data
				current = current.left
			else
				current = current.right
			end
		end
		nil				
	end

# def level_order(node=@root, level=0, result=[], &block)
# 	return if node.nil?

# 	result[level] ||= []

# 	block_given? ? yield(node) : result[level] << node.data
	

# 	level_order(node.left, level+1, result, &block)
# 	level_order(node.right, level+1, result, &block)

# 	result		
# end	
	
	def level_order(node=@root)
		return [] if node.nil?

		queue = [node]
		result = []
		level = 0

		until queue.empty?
			len_q = queue.length
			result << []

			len_q.times do

				node = queue.shift
				block_given? ? yield(node) : result[level] << node.data

				queue << node.left if node.left
      	queue << node.right if node.right
			end
			level +=1
		end			
		result
	end

	def inorder(node=@root, result=[], &block)
		return if node.nil?

		inorder(node.left, result, &block)
		block_given? ? yield(node) : result << node.data
		inorder(node.right, result, &block)
		result
	end

	def preorder(node=@root, result=[], &block)
		return if node.nil?

		block_given? ? yield(node) : result << node.data
		preorder(node.left, result, &block)
		preorder(node.right, result, &block)
		result
	end

	def postorder(node=@root, result=[], &block)
		return if node.nil?

		
		postorder(node.left, result, &block)
		postorder(node.right, result, &block)
		block_given? ? yield(node) : result << node.data
		result
	end

	def height(node=@root, value)

		return -1 if node.nil?

		left_height = height(node.left, value)
		right_heigth = height(node.right, value)

		[left_height, right_height].max + 1
	end

	# def depth(node = @root, value)
  # 	return -1 if node.nil?
  # 	return 0 if node.data == value

  # 	left_depth = depth(node.left, value)
  # 	return left_depth + 1 if left_depth >= 0 

  # 	right_depth = depth(node.right, value)
  # 	return right_depth + 1 if right_depth >= 0 
  
  # 	return -1
	# end

	def depth(node)
		result = level_order
		result.each_with_index do |sub_arr, level| 
			if sub_arr.include? value
				return level
			end
		end		
		-1	
	end

	def balanced? (node = @root)
		return true if node.nil?
		lheight = tree_heigth(node.left)
		rheigth = tree_heigth(node.right)

		return false if (lheight - rheigth).abs > 1
		balanced?(node.left) && balanced?(node.right)
	end

	def rebalance
		array = inorder
		@root = build_tree(array)
	end	

	private
		def tree_heigth(node)
			return 0 if node.nil?
			1 + [tree_heigth(node.left), tree_heigth(node.right)].max	
		end 			
end

	

# Driver script
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

puts "Initial tree:"
tree.pretty_print

puts "Is the tree balanced? #{tree.balanced?}"

puts "Level order traversal: #{tree.level_order}"
puts "Preorder traversal: #{tree.preorder}"
puts "Postorder traversal: #{tree.postorder}"
puts "Inorder traversal: #{tree.inorder}"

5.times { tree.insert(rand(101..200)) }

puts "\nAfter inserting 5 large numbers:"
tree.pretty_print

puts "Is the tree now unbalanced? #{tree.balanced?}"

tree.rebalance

puts "\nAfter rebalancing:"
tree.pretty_print

puts "Is the tree balanced again? #{tree.balanced?}"

puts "Level order traversal: #{tree.level_order}"
puts "Preorder traversal: #{tree.preorder}"
puts "Postorder traversal: #{tree.postorder}"
puts "Inorder traversal: #{tree.inorder}"