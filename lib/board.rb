
class GameBoard < RenderObject
	attr_accessor :board


	def initialize window, width = 10, height = 10
		@board = Array.new(height) { Array.new(width) }
		
		@offset_x = 40
		@offset_y = 40
    @height = height
    @width = width
    
		@tile_size = 45
		@padding = 4
	  
	  super(window, @offset_x, @offset_y)
	  
	  @blocked = [ [2, 4], [2, 5], [3, 4], [3, 5] ] #First set of inaccessible spaces
	  @blocked += [ [6, 4], [6, 5], [7, 4], [7, 5] ]
	  
	  @selected_piece = nil
	end
	
	
	def update

	end


	def draw
		each_index do |x, y|
			piece = at? x, y
			rx = real_x(x)
			ry = real_y(y)
			
			opts = {}
			
			if piece
			  #if piece == @current_player.selected_piece
			  #  opts[:selected] = true
		    #end
		    if piece.mouse_over?
		      opts[:mouse_over] = true
	      end
	      
	      if piece == @selected_piece
	        opts[:selected] = true
        end
			  piece.draw opts
			else
			  if @blocked.include?([x,y])
			    @window.draw_rect(rx, ry, @tile_size, @tile_size, Gosu::Color::BLACK)
		    else
			    @window.draw_rect(rx, ry, @tile_size, @tile_size, Gosu::Color.new(255,100,100,100))
			    @default_font.draw("-", real_x(x), real_y(y), 0)
		    end
		  end
		end
	end
	
	
	def self.combine window, top, bottom
	  b = GameBoard.new(window, 10, 10)
    empty = [Array.new(10), Array.new(10)]
    b.board = top.board.reverse + empty + bottom.board
    b.update_positions
    return b
	end
	
	def self.small_board window
	  return GameBoard.new(window, 10, 4)
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
	  return nil if !(0..@width-1).include?(x) || !(0..@height-1).include?(y)
		return @board[y][x]		
	end
	
	
	def set object, x, y
	  @board[y][x] = object
	end
	
	
	def remove x, y
	  @board[y][x] = nil
	end


	def mouse_over?
		mx = @window.mouse_x
		my = @window.mouse_y
		if mx > @offset_x && my > @offset_y &&
			mx < @offset_x + width && my < @offset_y + height
			return true
		end
		return false
	end


	def width
		return (@tile_size+@padding)*@width
	end


	def height
		return (@tile_size+@padding)*@height
	end


	def mouse_at?
		return false	
	end
	
	def remaining_places
	  remaining = []
	  each_index do |x, y|
	    if !at? x, y
	      remaining << [x, y]
      end
    end
    return remaining
	end
	
	def to_s
	  puts "-"* 30
	  @board.each do |line|
	    line.each do |piece|
	      print piece.to_s + "  "
      end
      puts "";
	  end
	  puts "-"*30
	end
	
	def update_positions
	  each_index do |x, y|
	    piece = at?(x, y)
	    piece.set_position(real_x(x), real_y(y)) if piece
	  end
	end
	
	def select_piece piece
	  @selected_piece = piece
  end
end
