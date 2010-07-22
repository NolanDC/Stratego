
class GameBoard < RenderObject
	attr_accessor :board
	LENGTH = 10

	def initialize window
		@board = Array.new(10) { Array.new(10) }
		
		@offset_x = 100
		@offset_y = 100
    
		@tile_size = 30
		@padding = 4


		@placer = PiecePlacer.new(window, 500,400)
		

	  
	  super(window, @offset_x, @offset_y)
	end
	
	def update
	  if mouse_on?
	    bx = board_x(window.mouse_x)
	    by = board_y(window.mouse_y)
	    rx = real_x(bx)
	    ry = real_y(by)
	    
	    piece = at? bx, by	
	    #	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	    if piece.nil? && @window.button_down?(Gosu::MsLeft) && @placer.left?(@placer.chosen)
	      #Piece.new(@window, @placer.chosen, rx, ry
	      set Piece.new(@window, @placer.chosen, rx, ry), bx, by
	      @placer.remove
	    end
    end
	  
	  @placer.update
	end

	def draw
		each_index do |x, y|
			piece = at? x, y
			if piece
			  piece.draw
			else
			  @default_font.draw("-", real_x(x), real_y(y), 0)
		  end
		end
		@placer.draw
	end

	def real_x x
		return @offset_x + x*(@tile_size+@padding)
	end

	def real_y y
		return @offset_y + y*(@tile_size+@padding)
	end

  def board_x x
    return ((x-@offset_x)/(@tile_size+@padding)).floor
  end
  
  def board_y y
    return ((y-@offset_y)/(@tile_size+@padding)).floor        
  end
  
	def each_index
		@board.each_index do |y|
			@board[y].each_index do |x|
				yield(x, y)
			end
		end
	end

	def each_item 
		each_index do |x, y|
			yield @board[y][x]
		end
	end

	def collect
		each_index do |x, y|
			@board[y][x] = yield(x, y)
		end
	end

	def at? x,  y
	  return nil if !(0..9).include?(x) || !(0..9).include?(y)
		return @board[y][x]		
	end
	
	def set object, x, y
	  @board[y][x] = object
	end

	def mouse_on?
		mx = @window.mouse_x
		my = @window.mouse_y
		if mx > @offset_x && my > @offset_y &&
			mx < @offset_x + width && my < @offset_y + height
			return true
		end
		return false

	end

	def width
		return (@tile_size+@padding)*LENGTH
	end

	def height
		return (@tile_size+@padding)*LENGTH
	end

	def mouse_at?
		return false	
	end
end
