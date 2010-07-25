

class Game
  def initialize window
    @window = window
		@board = GameBoard.new window, 10, 4
		@piece_placer = PiecePlacer.new(window, 500,400)
		
		@mouse_pointer = Rectangle.new(window, 1, 1, 3, 3)
		@mouse_pointer.color = Gosu::Color::RED

		@exit = Button.new(Rectangle.new(window, 0, 0, 400, 400))
		@phase = :setup 
		
		@players = [HumanPlayer.new, RandomComputerPlayer.new]
		@current_player = @players.first
		@mouse = Mouse.new(window)
		switch_phase(:play)
  end
  
  def update
    

	  
    case @current_player.owner
      when :human
        update_human
      when :computer
        update_computer
    end
    
    @mouse.update
	  @board.update
	  
	  #########################################
	  #  DEBUGGING 
	  #########################################
	  if self.button_down?(Gosu::KbY)
	    puts @board
	  end
	  
	  
  end
   
  
  def update_computer
    curr, target = @current_player.move(HiddenBoard.new(@board, @current_player))
    puts "#{curr} : #{target}"
    @board.move curr, target
    @current_player = @players.first
  end
    
  
  def update_human
    bx = @board.board_x(mouse_x())
    by = @board.board_y(mouse_y())
    rx = @board.real_x(bx)
    ry = @board.real_y(by)	  
	  case @phase
	    when :setup
	    
	      if @board.mouse_over?
	        piece = @board.at? bx, by	
	        #	def initialize(window, symbol, x, y, defeats, loses_to, moves)
	        if piece.nil? && @mouse.down?(:left) && @piece_placer.left?(@piece_placer.chosen)
	          #Piece.new(@window, @placer.chosen, rx, ry
	          @board.set Piece.new(@board, @current_player, @piece_placer.chosen, bx, by), bx, by
	          @piece_placer.remove
	        elsif !piece.nil? && @mouse.down?(:right)
	          @piece_placer.add piece.symbol
	          @board.remove bx, by
	        end	        
        end	 
        
        if piece.nil? && @mouse.down?(:right)
          place_random
        end    
        
        if @piece_placer.done? || self.button_down?(Gosu::KbSpace)
          switch_phase(:play)
        end        
        
	      @piece_placer.update        
	           		    
	    when :play
	      if @board.mouse_over?
	        piece = @board.at? bx, by
	        if @mouse.hit?(:left)
            if piece && piece.player == @current_player	      
              @board.select_piece(piece)
            else
              if @board.selected_piece
                #TODO add logic for checking if the piece can move there
                #In the board class, obviously
                if @board.can_move?(@board.selected_piece, [bx,by])
                  @current_player = @players.last
                  @board.move(@board.selected_position, [bx, by])
                  @board.deselect
                end
              end
            end
          end
       end
	  end  
  end  
  
  
  def place_random
    return if @piece_placer.done?
    
    place = @board.remaining_places.first
    return if place.nil?
    p = Piece.new(@board, @current_player, @piece_placer.chosen, 
                  place.first, place.last, @board.tile_size, @board.tile_size)
    @piece_placer.remove    
    @board.set p, place.first, place.last 
  end
  
  def draw
		@mouse_pointer.x = self.mouse_x
		@mouse_pointer.y = self.mouse_y
		@board.draw
		@mouse_pointer.draw	
		
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
