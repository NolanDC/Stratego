

class PiecePlacer < RenderObject
	def initialize window, x, y
		@pieces = Hash.new
		@pieces.merge!(Stratego::PIECE_COUNT)
		@background_rectangle = Rectangle.new(window, x, y, 200, 100)
		super(window, x, y)
		
		@done = Button.new(Rectangle.new(window, x, y+100, 50, 20), "Done")
		
		@buttons = []
		index = 0
		@pieces.each_pair do |key, value|
      text = "#{Stratego.short key}: #{value}"		
      b = Button.new(Rectangle.new(window, @x+4+((index%5)*40), @y+(20*(index/5).ceil)+4, 40, 20), text, key)
      if key == :scout
        @current_button = b
      end
      @buttons << b
      index+=1      
    end

	end
	
	def chosen
	  return @current_button.meta
	end
	
	def update
	  @buttons.each do |b|
	    if @window.button_down?(Gosu::MsLeft) && b.mouse_over?
	      @current_button = b
	    end
	  end
	end

	def draw 
	
	  @done.draw
		#@background_rectangle.draw	
		
		index = 0
		@buttons.each do |b|
		  b.draw
	  end
		  
	  @default_font.draw("Chosen: #{chosen.to_s.capitalize}", @x+88, @y+48, 0)
		
	end
	
	#	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	def remove
	  @pieces[chosen] -= 1
	  update_buttons chosen
	end
	
	def add sym
	  @pieces[sym] += 1
	  update_buttons sym
	end
	
	def update_buttons sym #total hack, wow
	  @buttons.each do |b|
	    if b.meta == sym
	      b.text = "#{Stratego.short b.meta}: #{@pieces[b.meta]}"
      end
    end
  end	
	
	def left? sym
	  return @pieces[sym]==0 ? false : true
	end
	
	def any_left?
	  return @pieces.keys.any? {|x| left? x}
	end
	
end
