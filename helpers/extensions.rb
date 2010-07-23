class Array
	def random
		return self[rand(length)]
	end

	def random_subset
		return select{|x| rand(2) == 1}
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

class Gosu::Window
#		@window.draw_quad(@x, @y, @color, @x+@width, @y, @color,	@x+@width, @y+@height, @color, @x, @y+@height, @color)
  def draw_rect x, y, width, height, color = Gosu::Color::WHITE
    self.draw_quad(x, y, color, x+width, y, color, x+width, y+height, color, x, y+height, color)
  end
end


