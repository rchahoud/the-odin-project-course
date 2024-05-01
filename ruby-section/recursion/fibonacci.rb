def recursive(n)
  return 0  if n == 0
  return 1 if n == 1
  return recursive(n-1) + recursive(n-2)
end

puts("Recursive output: #{recursive(4)}")

def iterative(n)
  fib = []

  n.times do |i|
    if i == 0
      fib.append(0)
      next

    elsif i == 1
      fib.append(1)
      next
    end

    aux = fib[i-1] + fib[i-2]
    fib.append(aux)
  end
  
  fib
end

puts("Iterative output: #{iterative(10)}")
