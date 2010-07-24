class HiddenPiece

end



class Piece < RenderObject
	attr_accessor :symbol, :player, :moves
	def initialize(window, player, symbol, x, y, width =45, height=45)
	  @player = player
		@symbol = symbol
		@defeats = Stratego::WIN_HASH[symbol]
		@loses_to = Stratego::LOSE_HASH[symbol]
		@moves = Stratego::MOVE_HASH[symbol]
		super(window, x, y)
		@width, @height = width, height
	end

  def copy
    return Piece.new(@window, @player, @symbol, @x, @y, @width, @height)
  end

	def wins? piece
		sym = piece.symbol
		return true if @defeats.include? sym
		return false
	end

	def loses? piece
		sym = piece.symbol
		return true if @loses_to.include? sym
		return false
	end
	
	def can_move?
	  return @moves > 0
  end
	
	def same? piece
	  return (piece.symbol == @symbol) ? true : false
  end
	
	def draw opts = {}
	  
	  color = @player.color.copy
	  
	  if opts[:selected]
	    color.alpha -= 100
    end
    
    if opts[:mouse_over]
      color.alpha -= 50
    end
    
    if opts[:hidden]
	    @window.draw_rect(@x, @y, @width, @height, color)
	    @default_font.draw(Stratego.short(@symbol), @x+2, @y+2, 0)	  
	  else
	  	@window.draw_rect(@x, @y, @width, @height, color)
	    @default_font.draw(Stratego.short(@symbol), @x+2, @y+2, 0)		  
	  end
	

	end

  def to_s
    return Stratego.short @symbol
  end
  
  def set_position x, y
    @x, @y = x, y  
  end
  
  def mouse_over?
    @window.mouse_over? @x, @y, @width, @height
  end
end
