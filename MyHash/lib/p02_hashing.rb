class Fixnum
  # Fixnum#hash already implemented for you

end

class Array
  def hash
    self.each_with_index.map do |el, i|
      (el*(i + 1)).hash
    end.reduce(:+).to_i + 1
  end
end

class String
  def hash
    self.each_byte.with_index.map do |char,i|
      (char * (i + 1)).hash
    end.reduce(:+).to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (to_a.sort.each_with_index.map do |arr, i|
      (arr[0].to_s.hash + arr[1].to_s.hash) * i
    end.reduce(:+)).to_i + 1
  end
end
