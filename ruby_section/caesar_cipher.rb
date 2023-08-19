def caesar_cipher (message, jumps) 
  chars = message.delete(" ").split("")
  encoded = []

  for char in chars
    encoded_char = char
    jumps.times do
      encoded_char = encoded_char.next
    end
    encoded.push(encoded_char)
  end
  encoded.join
end

puts "Please enter the message: "
message = gets 
puts "How many jumps with each letter you want to jump? "
jumps = gets 

puts caesar_cipher(message, jumps.to_i)
