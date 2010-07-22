

class Rectangle < RenderObject
  attr_accessor :width, :height
  
	def initialize window, x, y, width, height, color = Gosu::Color::WHITE
		@width, @height = width, height
		@color = color
		super(window, x, y)
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
