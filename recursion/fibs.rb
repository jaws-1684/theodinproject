# def fibs(num)
#   sequence = []
#   x, y = 0, 1

#   loop do
#     sequence << x
#     break if arr.length >= num 

#     x, y = y, x + y
#   end

#   sequence
# end
# puts fibs(8) 

# def fibbonaci(n)
#   return 0 if n == 1
#   return 1 if n == 2

#   fibbonaci(n-1) + fibbonaci(n-2)
# end

# def fibbonaci_generator(n)
#   sequence = []
#   (1..n).each do |i|
#     sequence << fibbonaci(i)
#   end
#   sequence
# end  

# print fibbonaci_generator(8)