def bubble_sort(unsorted_array)

  n = unsorted_array.length - 1
  
  n.times do |i|
    m = unsorted_array.length - i -1 

    m.times do |j|
      if unsorted_array[j] > unsorted_array[j + 1]
        unsorted_array[j], unsorted_array[j + 1] = unsorted_array[j + 1], unsorted_array[j]
      end
    end

  end
  unsorted_array
end

unsorted_array = [5,4,2,1,4,5,6,2,2,64,54,23,23]

sorted_array = bubble_sort(unsorted_array)

puts sorted_array