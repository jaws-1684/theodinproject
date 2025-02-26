class Knight
  def initialize(start_pos, end_pos)
    @start = start_pos
    @end = end_pos
  end

  def possible_moves(pos)
    x, y = pos
    moves = [
      [x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1],
      [x+1, y+2], [x+1, y-2], [x-1, y+2], [x-1, y-2]
    ].select { |nx, ny| nx.between?(0, 7) && ny.between?(0, 7) }
    moves
  end

  def self.knight_moves(start_pos, end_pos)
    
    knight = new(start_pos, end_pos)
    path = knight.find_shortest_path
    knight.print_path(path)
    path
  end
  
  def find_shortest_path
    return [@start] if @start == @end

    queue = [@start]
    
    visited = { @start => nil }
    

    until queue.empty?
      current = queue.shift
      
      return reconstruct_path(visited, current) if current == @end

      possible_moves(current).each do |move|
       
        if visited.key?(move)
          next
        end

        visited[move] = current
        queue << move
        
      end
    end
    nil
  end

  def reconstruct_path(visited, end_node)
    path = []
    current = end_node

    while current
      path.unshift(current)
      current = visited[current]
    end
    path  
  end

  def print_path(path)
    if path
      puts "You made it in #{path.length - 1} moves! Here's your path:"
      path.each { |pos| p pos } 
    else
      puts "No path exists between #{@start} and #{@end}!"
    end
  end
end


Knight.knight_moves([0,0], [6,8])
