def recursive(n)
  return 0  if n == 0

  return 1 if n == 1

  return recursive(n-1) + recursive(n-2)
end

puts("Recursive output: #{recursive(4)}")
