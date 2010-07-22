require 'rubygems'
require 'gosu'
require 'extensions'
require 'render_object'
require 'board'
require 'piece_placer'
require 'rect'
require 'stratego'
require 'piece'
require 'button'
$pieces = %w{2 3 4 5 6 7 8 9 10 s b f}


class GameWindow < Gosu::Window
  GAME_PHASES=[:setup, :play]
  
	def initialize
		super(800, 600, false)
		self.caption = "Gosu Tutorial Game"
		@board = GameBoard.new self
		@piece_placer = PiecePlacer.new(self, 500,400)
		
		@mouse = Rectangle.new(self, 1, 1, 3, 3)
		@mouse.color = Gosu::Color::RED

		@exit = Button.new(Rectangle.new(self, 0, 0, 400, 400))
		@phase = :setup
	end

	def update
	
	  if @board.mouse_on?
	    bx = @board.board_x(self.mouse_x)
	    by = @board.board_y(self.mouse_y)
	    rx = @board.real_x(bx)
	    ry = @board.real_y(by)
	    
	    piece = @board.at? bx, by	
	    #	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	    if piece.nil? && self.button_down?(Gosu::MsLeft) && @piece_placer.left?(@piece_placer.chosen)
	      #Piece.new(@window, @placer.chosen, rx, ry
	      @board.set Piece.new(self, @piece_placer.chosen, rx, ry), bx, by
	      @piece_placer.remove
	    elsif !piece.nil? && self.button_down?(Gosu::MsRight) 
	      @piece_placer.add piece.symbol
	      @board.remove bx, by
	    end
    end
    
    if @piece_placer.done?
      set_phase :play
    end
	  
	  case @phase
	    when :setup
	      @piece_placer.update		    
	    when :play
	    
	  end

	  @board.update
	end

	def draw
		@mouse.x = self.mouse_x
		@mouse.y = self.mouse_y
		@board.draw
		@mouse.draw	
		
	  case @phase
	    when :setup
	      @piece_placer.draw		    
	    when :play
	    
	  end
	end
	
	def set_phase phase
	  @phase = phase
	end
end

def window
	return $game_window
end

$game_window = GameWindow.new



$game_window.show
