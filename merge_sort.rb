def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])
  
  merge(left, right)
end

def merge(left, right)
  result = []

  loop do
    break if left.empty? || right.empty?

    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end

  result + left + right
end

arr = [105, 79, 100, 110]
sorted_arr = merge_sort(arr)
puts sorted_arr.inspect
