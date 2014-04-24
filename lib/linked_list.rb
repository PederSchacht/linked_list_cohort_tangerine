require 'linked_list_item'

class LinkedList
  attr_reader :size

  def initialize(*payloads)
    @size = 0
    payloads.each {|payload| add_item(payload)}
  end

  def add_item(payload)
    new_item = LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = new_item
    else
      item = @first_item
      until item.last?
        item = item.next_list_item
      end
      item.next_list_item = new_item
    end
    @size += 1
  end

  def get(i)
    get_item(i).payload
  end
  alias [] get

  def []=(index, value)
    get_item(index).payload = value
  end

  def remove(index)
    @size -= 1
    if index == 0
      @first_item = @first_item.next_list_item
    else
      previous_item = get_item(index - 1)
      next_list_item = previous_item.next_list_item.next_list_item
      previous_item.next_list_item = next_list_item
    end
  end

  def last
    size == 0 ? nil : get(size - 1)
  end

  def to_s
    reply = "|"
    item = @first_item
    until item.nil?
      reply << " " +  item.payload.to_s
      reply << "," unless item.last?
      item = item.next_list_item
    end
    reply + " |"
  end

  def indexOf(payload)
    item = @first_item
    position = 0
    until item.nil?
      return position if item.payload == payload
      position += 1
      item = item.next_list_item
    end
    nil
  end

  def sorted?
    item = @first_item
    until item.nil? || item.last?
      return false if item > item.next_list_item
      item = item.next_list_item
    end
    true
  end

  def sort
    if @size <= 1
      self
    else
      while true
        item = @first_item
        index = 0
        swap = false
        (@size - 1).times do
          if item > item.next_list_item
            swap_with_next(index)
            swap = true
          else
            item = item.next_list_item
          end
          index += 1
        end
        break unless swap
      end
      self
    end
  end

  def swap_with_next(index)
    raise IndexError if index < 0 || index >= (@size - 1)

    if index == 0
      item1 = @first_item
      item2 = item1.next_list_item
      item1.next_list_item = item2.next_list_item
      item2.next_list_item = item1
      @first_item = item2
    else
      current = @first_item
      (index - 1).times {current = current.next_list_item}
      previous = current
      item1 = previous.next_list_item
      item2 = item1.next_list_item
      previous.next_list_item = item2
      item1.next_list_item = item2.next_list_item
      item2.next_list_item = item1
    end
  end

  private

  def get_item(index)
    raise IndexError if index < 0 || index >= size
    item = @first_item
    index.times {item = item.next_list_item}
    item
  end
end
