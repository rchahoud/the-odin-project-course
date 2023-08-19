def stock_picker(values)
  best_trade = Hash.new
  best_trade['buy_day'] = 0
  best_trade['sell_day'] = 0
  best_trade['total'] = 0
  
  (values.length - 1).times do |i|
    first_value = values[i+1] - values[i]
    
    (i + 1..values.length - 1).each do |j|
      if best_trade['total'] < values[j] - values[i]
        best_trade['total'] = values[j] - values[i]
        best_trade['buy_day'] = i
        best_trade['sell_day'] = j
      end
    end
  end
  best_trade
end

best_trade = stock_picker([17,3,6,9,15,8,6,1,10])
profit = best_trade['total']
buy_day = best_trade['buy_day'] + 1
sell_day = best_trade['sell_day'] + 1

puts "For the best profit, which is $#{best_trade['total']}, buy in the day #{buy_day} and sell in the day #{sell_day}"
