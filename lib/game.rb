

class Game
  def initialize window
    @window = window
		@board = GameBoard.new window, 10, 4
		@piece_placer = PiecePlacer.new(window, 500,400)
		
		@mouse = Rectangle.new(window, 1, 1, 3, 3)
		@mouse.color = Gosu::Color::RED

		@exit = Button.new(Rectangle.new(window, 0, 0, 400, 400))
		@phase = :setup 
		
		@players = [HumanPlayer.new, RandomComputerPlayer.new]
		@current_player = @players.first
		
		switch_phase(:play)
  end
  
  def update

    bx = @board.board_x(mouse_x())
    by = @board.board_y(mouse_y())
    rx = @board.real_x(bx)
    ry = @board.real_y(by)	
	  
	  case @phase
	    when :setup
	    
	      if @board.mouse_over?
	        piece = @board.at? bx, by	
	        #	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	        if piece.nil? && self.button_down?(Gosu::MsLeft) && @piece_placer.left?(@piece_placer.chosen)
	          #Piece.new(@window, @placer.chosen, rx, ry
	          @board.set Piece.new(@window, @current_player, @piece_placer.chosen, rx, ry), bx, by
	          @piece_placer.remove
	        elsif !piece.nil? && self.button_down?(Gosu::MsRight) 
	          @piece_placer.add piece.symbol
	          @board.remove bx, by
	        end	        
        end	 
        
        if piece.nil? && self.button_down?(Gosu::MsRight)
          place_random
        end    
        
        if @piece_placer.done? || self.button_down?(Gosu::KbSpace)
          switch_phase(:play)
        end        
        
	      @piece_placer.update             		    
	    when :play
	      if @board.mouse_over?
	        piece = @board.at? bx, by
	        if self.button_down?(Gosu::MsLeft)
	          if piece.player == @current_player	      
              @board.select_piece(piece)
            end
          end
       end
	  end

	  @board.update
	  
	  #########################################
	  #  DEBUGGING 
	  #########################################
	  if self.button_down?(Gosu::KbY)
	    puts @board
	  end
	  
	  
  end
  
  def place_random
    return if @piece_placer.done?
    
    place = @board.remaining_places.first
    return if place.nil?
    p = Piece.new(@window, @current_player, @piece_placer.chosen, 
                  @board.real_x(place[0]), @board.real_y(place[1]))
    @piece_placer.remove    
    @board.set p, place[0], place[1]   
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
  
  
  def mouse_x
    return @window.mouse_x
  end
  
  def mouse_y
    return @window.mouse_y
  end
  
  def button_down? btn
    return @window.button_down? btn
  end
  
  def switch_phase(phase)
    @phase = phase
    case phase
      when :play
        comp_board = @players.last.starting_board( GameBoard.small_board( @window ) )
        #temporary so I don't have to fill in a new one each time!
        if @piece_placer.done?
          player_board = @board
        else
          player_board = @players.last.starting_board( GameBoard.small_board( @window ))
          player_board.each_item do |x|
            x.player = @players.first
          end
        end
        @board = GameBoard.combine( @window, comp_board, player_board )
      when :setup
      
    end
  end
  
end
