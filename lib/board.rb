class GameBoard < RenderObject
	attr_accessor :board, :selected_piece, :tile_size, :notifications


	def initialize window, width = 10, height = 10, tile_size = 40
		@board = Array.new(height) { Array.new(width) }

    @height = height
    @width = width
    
		@tile_size = tile_size
		@padding = 4
		
		@offset_y = (window.height - self.real_height)/2		
		@offset_x = @offset_y

	  
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
			    @window.draw_rect(rx, ry, @tile_size, @tile_size, Gosu::Color.new(255,100,100,100))			
			if piece

		    if piece.mouse_over?
		      opts[:mouse_over] = true
	      end
	      
	      if piece == @selected_piece
	        opts[:selected] = true
        end
        
        if piece.player.owner != :human
          opts[:hidden] = true
        end
			  piece.draw opts
			else
			  if @blocked.include?([x,y])
			    @window.draw_rect(rx, ry, @tile_size, @tile_size, Gosu::Color::BLACK)
		    else

			    #@default_font.draw("-", real_x(x), real_y(y), 0)
		    end
		  end
		end
	end
	
	#expects a piece and an array; i.e. can_move?(a_piece, [3,4])
	def can_move? piece, target
	  return false if piece.nil?
	  cx, cy = piece.x, piece.y
	  tx, ty = target.first, target.last
	  	
	  return false if @blocked.include? target #Cannot move into the center blocked squares
	  return false if piece.moves == 0 #Either a bomb or a target	  
	  return false if ((cx-tx).abs + (cy-ty).abs) > piece.moves #Out of the pieces range	  
	  return false if !(cx == tx) && !(cy == ty) #The move must be in a straight line
	  [cx, tx].each {|x| return false if !(0...@width).include?(x) } #safety precautions for AI
	  [cy, ty].each {|y| return false if !(0...@height).include?(y) } #ditto
	  
	  if at?(tx, ty)
	    return false if at?(tx, ty).player == piece.player #Can't move onto your own player
	  end
	  
	  cx.between_array(tx).each do |x|
	    cy.between_array(ty).each do |y|
	      return false if !at?(x, y).nil? || @blocked.include?([x, y])
	    end
    end
	  
	  return true 
	end
	
	
	#Expects two arrays of positions, i.e. [1,2], [1,3]
	#Returns the message to be added to the notifications
	def move curr, target 
	  piece = at?(curr.first, curr.last)
	  enemy = at?(target.first,target.last)
	  
	  if enemy
	    if piece.same?(enemy)
	      remove(target.first, target.last)
	      remove(curr.first,curr.last)
	      move_object = MoveObject.new(:suicide, piece.player, piece, enemy)
	    elsif piece.wins?(enemy) #Piece wins against enemy!
	      remove(target.first, target.last)
	      remove(curr.first, curr.last)
        move_object = MoveObject.new(:win, piece.player, piece, enemy)
	      place(piece, target.first, target.last)
      else #Piece loses.. 
        move_object = MoveObject.new(:loss, piece.player, piece, enemy)
        remove(curr.first, curr.last)
      end
	  else #No enemy, just move the player
	   move_object = MoveObject.new(:move, piece.player, piece)
	   place(piece, target.first, target.last)
	   remove(curr.first, curr.last)
    end
    return move_object
	end
	
	
	def place piece, bx, by #Places a piece at a place, with proper coordinates, etc..
	  piece.x, piece.y = bx, by
	  set(piece, bx, by)
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


  def free? x, y
    return false if @blocked.include([x,y]) || at?(x,y)
    return true
  end
  

	def at? x,  y
	  return nil if !(0..@width-1).include?(x) || !(0..@height-1).include?(y)
	  return nil if @blocked.include?([x,y])
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
			mx < @offset_x + real_width && my < @offset_y + real_height
			return true
		end
		return false
	end


	def real_width
		return (@tile_size+@padding)*@width
	end


	def real_height
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
	      if piece && piece.class == Piece 
	        print piece.to_s + "  "
        else
          print "   "
        end
      end
      puts "";
	  end
	  puts "-"*30
	end
	
	
	def update_positions
	  each_item do |p|
	    p.board = self if p
    end
	  each_index do |x, y|
	    piece = at?(x, y)
	    piece.set_position(x, y) if piece
	  end
	end
	
	
	def select_piece piece
	  @selected_piece = piece
  end
  
  
  def deselect
    @selected_piece = nil
  end
  
  
  def selected_position
    return [@selected_piece.x, @selected_piece.y]
  end

  
  def possible_moves piece
    bx = piece.x
    by = piece.y
    return [ [bx+1, by], [bx-1, by], [bx, by+1], [bx, by-1] ].select do |pos|
      can_move?(piece, pos)
      #free?(pos.first, pos.last) || (at?(pos.first, pos.last) != nil && at?(post.first,post.last).player != piece.player)
    end
  end
  
  def locked? piece #True if a piece is locked in
    return possible_moves(piece).size == 0
  end
end

#Hidden board uses non-real coordinates, using the array ones instead
class HiddenBoard < GameBoard
  def initialize board, player
    super(board.window, board.width, board.height)
    @player = player
    board.each_index do |x, y|
      piece = board.at?(x,y)
      if piece
        if piece.player != player
          set(HiddenPiece.new, x, y)
        else
          p = piece.copy

          set(p, x, y)
        end
      end
    end
  end
  
  def free_pieces
    free = []
    each_item do |item|
      if item.class == Piece
        if !locked?(item)
          free << item
        end
      end
    end 
    return free
  end
end

