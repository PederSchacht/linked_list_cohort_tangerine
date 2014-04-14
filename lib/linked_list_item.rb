class LinkedListItem
  include Comparable
  attr_accessor :payload
  attr_reader :next_list_item

  def initialize(payload)
    @payload = payload
    @next_list_item = nil
  end

  def next_list_item=(str)
    if str == self
      raise ArgumentError
    else
      @next_list_item = str
    end
  end

  def last?
    @next_list_item.nil?
  end

  def <=>(another_item)
    head = self.payload.to_s
    tail = another_item.payload.to_s
    head <=> tail
  end

  def ===(b)
    self.equal?(b)
  end

end
