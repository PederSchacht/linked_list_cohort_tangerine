require 'linked_list_item'

class LinkedList
  attr_accessor :head_item, :tail_item

  def initialize(*args)
    self.tail_item = nil
    args.each {|arg| self.add_item(arg)}
  end

  def add_item(item)
    new_item = LinkedListItem.new(item)
    if self.head_item == nil
      self.head_item = new_item
    else
      current = self.head_item
      while current.next_list_item != nil
        current = current.next_list_item
      end
      current.next_list_item = new_item
    end
    self.tail_item = new_item
  end

  def get(point, *mod)
    current = self.head_item
    if point < 0
      raise IndexError
    end
    (0..point).each do |place|
      if current == nil
        raise IndexError
      elsif place == point
        current.payload = mod[0] if mod.length != 0
        return current if caller.include?("remove")
        return current.payload
      else
        current = current.next_list_item
      end
    end
  end

  def remove(point)
    point > 0 ? prior = self.get(point - 1) : prior = self.head_item
    # prior.next_list_item = self.get(point + 1) if self.size > point + 1
    self.size > point + 1 ? prior.next_list_item = self.get(point + 1) : prior.next_list_item = nil
  end

  def size
    size = 0
    current = self.head_item
    while current != nil
      size += 1
      current = current.next_list_item
    end
    size
  end

  def last
    self.tail_item != nil ? self.tail_item.payload : nil
  end

  def to_s
    reply = "| "
    current = self.head_item
    while current != nil
      reply = reply + current.payload.to_str
      current = current.next_list_item
      current != nil ? reply = reply + ", " : reply = reply + " "
    end
    reply = reply + "|"
  end

  def [] num
    self.get(num)
  end

  def []= num, item_mod
    self.get(num, item_mod)
  end

end
