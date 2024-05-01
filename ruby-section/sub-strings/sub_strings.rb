def main(word, dictionary)
  sub_strings = Hash.new
  
  dictionary.map { |word| 
    word.downcase!
  }
 
  dictionary.each do |dict_word|
    word.each_char.with_index do |char, index|
      if (char == dict_word[0]) && word[index, dict_word.length] == dict_word
        #or instead of word[index..-1], we can use the dict_word
        puts word[index, dict_word.length] 
      end
    end
  end
end




dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
main("going", dictionary)
