class Array
  def my_uniq
    temp_storage = {}
    self.each do |e|
      temp_storage[e] = 1 unless temp_storage.keys.include?(e)
    end
    temp_storage.keys
  end

  def two_sum
    result = []
    len = self.length
    self.each_index do |i|
      for second_index in (i + 1)..(len - 1)
        first_num = self[i]
        second_num = self[second_index]
        if first_num + second_num == 0
          result.push([i, second_index])
        end
      end
    end

    result
  end
end


def my_transpose(matrix)
  results = []

  for i in 0..(matrix[0].length - 1)
    temp = []
    matrix.each do |sub_array|
      temp << sub_array[i]
    end
    results << temp
  end

  results
end

def stock_picker(array)
  buy_i = 0
  sell_i = 0
  most_profit = 0

  array.each_with_index do |day_value, i|
    sell_date = i + 1
    while sell_date < array.size
      if most_profit < array[sell_date] - day_value
        most_profit = array[sell_date] - day_value
        buy_i = i
        sell_i = sell_date
      end
      sell_date += 1
    end
  end

  p "You should buy #{buy_i} and sell #{sell_i}"

end
