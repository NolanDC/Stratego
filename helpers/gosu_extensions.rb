class Gosu::Window
#		@window.draw_quad(@x, @y, @color, @x+@width, @y, @color,	@x+@width, @y+@height, @color, @x, @y+@height, @color)
  def draw_rect x, y, width, height, color = Gosu::Color::WHITE
    self.draw_quad(x, y, color, x+width, y, color, x+width, y+height, color, x, y+height, color)
  end
  
  def mouse_over? x, y, w, h
    if mouse_x >= x and mouse_x < x+w
      if mouse_y >= y and mouse_y < y+h
        return true
      end
    end
    return false
  end
end
