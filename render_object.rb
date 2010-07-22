

class RenderObject
	attr_accessor :x, :y, :window, :color
  
  def initialize window, x, y, color = Gosu::Color::WHITE
    @color = color
    @window = window
    @x, @y = x, y
    @default_font = Gosu::Font.new(window, Gosu::default_font_name, 16)
  end
  
  def draw window
    @default_font.draw("Object:#{self.class}", @x, @y, 0)
  end
end
