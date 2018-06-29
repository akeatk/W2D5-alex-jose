require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    if @store.length == count
      resize!
    end
    self[key] << key
    @count += 1
    true
  end

  def include?(key)
    # byebug
    self[key].include?(key)
  end

  def remove(key)
    return false unless include?(key)
    self[key].delete(key)
    @count -= 1
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[(num.hash % num_buckets)]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |key|
        temp[key.hash % (num_buckets * 2)] << key
      end
    end
    @store = temp
  end
end
