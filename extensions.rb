class Array
	def random
		return self[rand(length)]
	end

	def random_subset
		return select{|x| rand(2) == 1}
	end
end


