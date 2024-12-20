def bubble_sort(arr)
    n = arr.length
    loop do
        newn = 0
        for i in 1...(n)
            if arr[i-1] > arr[i]
                arr[i-1], arr[i] = arr[i], arr[i-1]
                newn = i
            end    
        end
    n = newn
    break if n <= 1    
    end
    arr
end

p bubble_sort([4, 3, 78, 2, 0, 2])


