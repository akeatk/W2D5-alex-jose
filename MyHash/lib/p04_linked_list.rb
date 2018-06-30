require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    prev.next = @next
    @next.prev = prev
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = @head.next

    while node.next != nil
      return node.val if node.key == key
      node = node.next
    end

    nil
  end

  def include?(key)
    any? {|node| node.key == key}
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = @tail
    @tail.prev.next = node
    node.prev = @tail.prev
    @tail.prev = node
    node
  end

  def update(key, val)
    node = @head.next

    while node.next != nil
      break if node.key == key
      node = node.next
    end

    return nil if node == @tail
    node.val = val
    node
  end

  def remove(key)
    each do |node|
      return node.remove if key == node.key
    end
    nil
  end

  def each
    node = @head.next

    while node.next != nil
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
