arr = [17, 3, 6, 9, 15, 8, 6, 1, 10]

def stock_picker(arr)
	best_sell = nil	
	best_days = nil

	arr.each_with_index do |first_elem, i|
  	arr[i+1..-1].each_with_index do |second_elem, j|

      	result = second_elem - first_elem
      	sell_day = i        
      	buy_day = i + j + 1 
      
      	if best_sell.nil? || result > best_sell
        	best_sell = result
        	best_days = [sell_day, buy_day]
      	end

  	end
	end
	
	return best_sell, best_days	

end
 
best_sell, best_days, = stock_picker(arr)
puts "Best Sell: #{best_sell}"
puts "Best Days: #{best_days.inspect}"