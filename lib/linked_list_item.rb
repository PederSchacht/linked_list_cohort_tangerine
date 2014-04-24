class LinkedListItem
  include Comparable
  attr_accessor :payload
  attr_reader :next_list_item

  def initialize(payload)
    @payload = payload
  end

  def next_list_item=(item)
      raise ArgumentError if self === item
      @next_list_item = item
  end

  def last?
    @next_list_item.nil?
  end

  def <=>(another_item)
    payload1 = self.payload
    payload2 = another_item.payload

    precedence = [Fixnum, String, Symbol]
    index1 = precedence.index(payload1.class)
    index2 = precedence.index(payload2.class)
    class_equality = (index1 <=> index2)

    class_equality == 0 ? payload1 <=> payload2 : class_equality
  end

  def ===(other)
    self.equal? other
  end

end
