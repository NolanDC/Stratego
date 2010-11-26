

class Rectangle < RenderObject
  attr_accessor :width, :height, :color
  
	def initialize window, x, y, width, height, color = Gosu::Color::WHITE
		@width, @height = width, height
		super(window, x, y, color)
	end

	def draw
		@window.draw_quad(@x, @y, @color, @x+@width, @y, @color,	@x+@width, @y+@height, @color, @x, @y+@height, @color)
	end

	def within? x, y
		if x >= @x and y >= @y and x < @x+@width and y < @y+@height
			return true
		end
		return false
	end
end
