def fact(n)
  if n == 1
    return 1
  else
    return n * fact(n-1)
  end
end

def palindromo?(palavra, posicao = 0)
  inverso = (posicao + 1) * -1

  if posicao == palavra.length
    return true
  end

  if palavra[posicao] == palavra[inverso]
    return palindromo?(palavra, posicao + 1)
  else
    return false
  end
end

def bottles_of_beer_on_the_wall(n)
  if n == 0
    return "no more bottles of beer on the wall"
  else
    puts "bottles of beer on the wall: #{n}"
    return bottles_of_beer_on_the_wall(n-1)
  end
end

puts fact(3)
puts fact(4)
puts fact(5)

puts palindromo?("lolol")
puts palindromo?("tenet")
puts palindromo?("hi")

puts bottles_of_beer_on_the_wall(5)
