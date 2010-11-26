
class Button < Rectangle
  attr_accessor :meta, :text
  
	def initialize rect, text = "default", meta = ""
	  @meta = meta
	  @text = text
		super(rect.window, rect.x, rect.y, rect.width, rect.height, rect.color)
	end

	def draw
	  @color.alpha = mouse_over? ? 150 : 255
		super
		@default_font.draw(@text, @x+4, @y+4, 0, 1, 1, Gosu::Color::BLACK)
		@color.alpha = 255
	end
	
	def mouse_over?
		return within? window.mouse_x, window.mouse_y
	end
	
	def down? btn = :left
	  return false if !mouse_over?
    case btn
      when :left
        return true if @window.mouse.hit?(:left) #@window.button_down?(Gosu::MsLeft)
      when :right
        return true if @window.mouse.hit?(:right) #@window.button_down?(Gosu::MsRight)
    end
    return false
  end
end


