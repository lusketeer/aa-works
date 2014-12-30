def quick_sort(array)
  return array if array.size < 2
  piv = array.shift
  left, right = [], []
  array.each do |el|
    if el < piv
      left << el
    else
      right << el
    end
  end
  quick_sort(left) + [piv] + quick_sort(right)

end
