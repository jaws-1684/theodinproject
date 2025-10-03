module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    self.each do |elem|
      yield(elem, index)
      index += 1
    end
    self
  end

  def my_select
    selected_elements = Array.new
    self.each do |elem|
      selected_elements.append(elem) if yield(elem)
    end
    selected_elements
  end

  def my_all?
  
    self.each do |elem|
      return false unless yield(elem) 
    end

    true  
  end

  def my_any?
    self.each do |elem|
      return true if yield(elem) 
    end
    false
  end
  
  def my_none?
    self.each do |elem|
      return false if yield(elem)
    end
    true
  end

  def my_count

    return self.size unless block_given?

    count = 0
    self.each do |elem|
      if yield(elem)
        count += 1
      end
    end
    count
  end
  
  def my_map
    map = Array.new
    self.each do |elem|
      map << yield(elem)
    end
    map
  end

  def my_inject(initial=nil)
    accumulator = initial.nil? ? self.first : initial 

    self.my_each do |elem, index|
        accumulator = yield(accumulator, elem)
    end
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
# 
class Array
  def my_each
    self.each do |element|
      yield(element)
    end
    self 
  end
end