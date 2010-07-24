

class Player
  attr_accessor :color
  
  def initialize name, owner, color = Gosu::Color.new(255,200,30,30)
    @owner = owner
    @color = color
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
    super(name, :human, Gosu::Color.new(255,30,30,200))
  end
  
end

class ComputerPlayer < Player
  def initialize name=:computer
    super(name, :human)
  end
  
  def move board
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
      new_piece = Piece.new( board.window, self, p, rx, ry, board.tile_size, board.tile_size)
      board.set new_piece, s[0], s[1]
    end

    return board
  end
  
  #TODO What's proper, e.g. or i.e.??? 
  #returns a set of coordinates e.g. [1,2], [2,2]
  def move board
    free_pieces = board.free_pieces
    piece = free_pieces.random
    moves = board.possible_moves(piece)
    return [piece.x, piece.y], moves.random     
  end
end
