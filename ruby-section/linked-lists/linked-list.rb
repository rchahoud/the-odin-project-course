class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value)
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
    end
  end

  def size()
    if @head.nil?
      return 0
    else
      current_node = @head
      count = 0
      while current_node != nil
        count += 1
        current_node = current_node.next_node
      end
    end
    count
  end

  def head()
    @head
  end

  def tail()
    @tail
  end

  def at(index)
    current_node = @head
    count = 0
    while count < index
      current_node = current_node.next_node
      count += 1
    end
    current_node
  end

  def pop()
    current_node = @head
    while current_node.next_node != @tail
      current_node = current_node.next_node
    end
    current_node.next_node = nil
    @tail = current_node
  end

  def contains?(value)
    current_node = @head
    while current_node != nil
      if current_node.value == value
        return true
      end
      current_node = current_node.next_node
    end
    return false
  end

  def find(value)
    current_node = @head
    count = 0
    while current_node != nil
      if current_node.value == value
        return count
      end
      count += 1
      current_node = current_node.next_node
    end
    return nil
  end

  def to_s()
    current_node = @head
    str = ""
    while current_node != nil
      str = str + "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    str = str + "nil"
    str
  end

  def insert_at(value, index)
    if index < 0 || index > size()
      return "Index out of range"
    end
    
    if index == 0
      # Special case for inserting at the beginning
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
      @tail = new_node if @tail.nil?
      return
    end
    
    current_node = @head
    count = 0
    while current_node != nil
      if count == index - 1
        new_node = Node.new(value)
        new_node.next_node = current_node.next_node
        current_node.next_node = new_node
        # If the new node is inserted at the end, update @tail
        @tail = new_node if new_node.next_node.nil?
        break
      end
      current_node = current_node.next_node
      count += 1
    end
  end  

  def remove_at(index)
    if index < 0 || index >= size()
      return "Index out of range"
    end
    
    if index == 0
      # Special case for removing the first node
      @head = @head.next_node
      # If the list is now empty
      @tail = nil if @head.nil?
      return
    end

    current_node = @head
    count = 0
    while current_node != nil
      if count == index - 1
        current_node.next_node = current_node.next_node.next_node
        # If the next node is the current node is the new tail
        @tail = current_node if current_node.next_node.nil?
        break
      end
      current_node = current_node.next_node
      count += 1
    end
  end

end

linked_list = LinkedList.new
linked_list.append("J")
linked_list.append("K")
linked_list.append("L")
linked_list.append("M")
linked_list.prepend("G")

puts "Current list: #{linked_list}"
puts "Size: #{linked_list.size}"
puts "Head: #{linked_list.head.value}"
puts "Tail: #{linked_list.tail.value}"
puts "At index 0: #{linked_list.at(0).value}. At index 1: #{linked_list.at(1).value}"
puts "Contains X? #{linked_list.contains?("X")}. Contains L? #{linked_list.contains?("L")}"
puts "Find X: #{linked_list.find("X")}. Find M: #{linked_list.find("M")}"

linked_list.insert_at("F", 3)
puts "After insert F at position 3: \n#{linked_list}"

linked_list.pop
puts "After a pop: \n#{linked_list}"

linked_list.remove_at(1)
puts "After removing at position 1: \n#{linked_list}\n"