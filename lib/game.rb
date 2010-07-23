

class Game
  def initialize window
    @window = window
		@board = GameBoard.new window, 10, 4
		@piece_placer = PiecePlacer.new(window, 500,400)
		
		@mouse = Rectangle.new(window, 1, 1, 3, 3)
		@mouse.color = Gosu::Color::RED

		@exit = Button.new(Rectangle.new(window, 0, 0, 400, 400))
		@phase = :setup 
		
		@players = [HumanPlayer.new, ComputerPlayer.new]
		@current_player = @players.first
  end
  
  def update
	
	  if @board.mouse_on?
	    bx = @board.board_x(mouse_x())
	    by = @board.board_y(mouse_y())
	    rx = @board.real_x(bx)
	    ry = @board.real_y(by)
	    
	    piece = @board.at? bx, by	
	    #	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	    if piece.nil? && self.button_down?(Gosu::MsLeft) && @piece_placer.left?(@piece_placer.chosen)
	      #Piece.new(@window, @placer.chosen, rx, ry
	      @board.set Piece.new(@window, @piece_placer.chosen, rx, ry), bx, by
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
  
  
  def mouse_x
    return @window.mouse_x
  end
  
  def mouse_y
    return @window.mouse_y
  end
  
  def button_down? btn
    return @window.button_down? btn
  end
  
end
