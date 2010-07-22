

class Piece < RenderObject
	attr_accessor :symbol
	def initialize(window, symbol, x, y)
		@symbol = symbol
		@defeats = Stratego::WIN_HASH[symbol]
		@loses_to = Stratego::LOSE_HASH[symbol]
		@moves = Stratego::MOVE_HASH[symbol]
		super(window, x, y)
	end

	def wins? sym
		sym = sym.symbol
		return true if @defeats.include? sym
		return false
	end

	def loses? sym
		sym = sym.symbol
		return true if @loses_to.include? sym
		return false
	end
	
	def draw
	  @default_font.draw(Stratego.short(@symbol), @x, @y, 0)
	end

end
