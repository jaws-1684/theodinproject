# Stock Picker

This Ruby script contains the `stock_picker` method, which finds the best days to buy and sell stocks for maximum profit from an array of stock prices.

## How It Works
The `stock_picker` method takes an array of stock prices as input and returns:
1. The maximum profit (best sell value).
2. The days (indices) to buy and sell for that maximum profit.

### Example

```ruby
arr = [17, 3, 6, 9, 15, 8, 6, 1, 10]
best_sell, best_days = stock_picker(arr)
puts "Best Sell: #{best_sell}"
puts "Best Days: #{best_days.inspect}"
