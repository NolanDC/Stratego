class Array
	def random
		return self[rand(length)]
	end

	def random_subset
		return select{|x| rand(2) == 1}
	end
end

class Integer
  #Returns all the numbers in between in an array
  #Example: 9.between_array(6) => [7,8]
  def between_array num
    if self == num
      return [self]
    elsif self > num
      return (num+1...self).to_a.reverse
    else
      return (self+1...num).to_a
    end
  end
end

class Hash
  def random_key
    keys.random
  end
  
  def random_value
    self[random_key]
  end
end


