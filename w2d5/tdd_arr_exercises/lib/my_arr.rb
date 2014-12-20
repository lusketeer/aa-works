class Array
  def my_uniq
    return self.dup if self.length < 2
    new_arr = []
    self.each do |el|
      new_arr << el unless new_arr.include?(el)
    end
    new_arr
  end

  def two_sum
    return [] if self.length < 2
    indexes = []
    (0...(self.length - 1)).each do |n_1|
      ((n_1 + 1)...self.length).each do |n_2|
        indexes << [n_1, n_2] if self[n_1] + self[n_2] == 0
      end
    end
    indexes
  end
end

def my_transpose(arr)
  result = []
  arr.first.length.times do |col|
    temp_row = []
    arr.length.times do |row|
      temp_row << arr[row][col]
    end
    result << temp_row
  end
  result
end
