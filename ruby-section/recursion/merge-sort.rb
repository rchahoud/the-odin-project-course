def merge(array, first, mid, last)
  left = array[first..mid-1]
  right = array[mid..last-1]
  top_left = 0
  top_right = 0
  k = first

  while k <= last-1
    if top_right >= right.length
      array[k] = left[top_left]
      top_left += 1
    elsif top_left >= left.length
      array[k] = right[top_right]
      top_right += 1
    elsif left[top_left] < right[top_right]
      array[k] = left[top_left]
      top_left += 1
    else
      array[k] = right[top_right]
      top_right += 1
    end
    k += 1
  end
end

def mergesort(array, first=0, last=nil)
  if last == nil
    last = array.length
  end
  if last - first > 1
    mid = (first + last) / 2
    mergesort(array, first, mid)
    mergesort(array, mid, last)
    merge(array, first, mid, last)
  end
  array
end

arr = [4, 6, 2, 10, 1, 8, 7, 5]
puts("Unsorted array: #{arr}")
puts("Sorted array: #{mergesort(arr)}")
