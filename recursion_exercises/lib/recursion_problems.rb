#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.size == 0
  array.first + sum_recur(array.drop(1))
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return true if array.first == target
  return false if array.size == 0
  includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.size == 0
  if array.first == target
    return 1 + num_occur(array.drop(1), target)
  else
    num_occur(array.drop(1), target)
  end
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.size == 1
  return true if array[0] + array[1] == 12
  add_to_twelve?(array.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return true if array.size < 2
  (array[0] <= array[1]) && sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if (number / 10 == 0)
  digits = number.to_s.size - 1
  first_digit = number % 10 # move the last digit to first
  new_number = number / 10
  first_digit * (10 ** digits) + reverse(new_number)
end
