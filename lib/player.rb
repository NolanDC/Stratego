

class Player
  def initialize name, owner
    @owner = owner
  end
  
  
  def move 
  
  end
  
  
  def human?  
    return @owner == :human ? true :false
  end
  
  def computer?
    return @owner == :computer ? true : false
  end
end

class HumanPlayer < Player
  
  def initialize name=:human
    super(name, :human)
  end
  
end

class ComputerPlayer < Player
  def initialize name=:computer
    super(name, :human)
  end
  
  def starting_board board
  end
end

class RandomComputerPlayer < ComputerPlayer
  
  def starting_board board
    pieces = CountHash.from_hash( Stratego::PIECE_COUNT )
    spots = board.remaining_places
    #used spots so both didn't start with a p ;-)
    spots.each do |s|
      rx = board.real_x(s[0])
      ry = board.real_y(s[1])
      p = pieces.get( pieces.random_key )
      new_piece = Piece.new( board.window, self, p, rx, ry )
      board.set new_piece, s[0], s[1]
    end

    return board
  end
end
