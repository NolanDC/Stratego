

class Player
  attr_accessor :color, :owner
  
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
    super(name, :computer)
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
      p = pieces.get( pieces.random_key )
      new_piece = Piece.new( board, self, p, s[0], s[1], board.tile_size, board.tile_size)
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


class Beethoven < ComputerPlayer
  
  def initialize
    super(:Beethoven)
  end
  
  def starting_board board
    b = [
        [:major, :scout, :major, :scout, :leut, :scout, :sergeant, :miner, :scout, :leut],
        [:captain, :general, :colonel, :miner, :bomb, :captain, :miner, :marshal, :scout, :major],
        [:bomb, :leut, :scout, :miner, :captain, :scout, :colonel, :bomb, :sergeant, :captain],
        [:sergeant, :bomb, :scout, :scout, :sergeant, :leut, :bomb, :flag, :bomb, :miner]
        ]
      4.times do |y|
        10.times do |x|
          p = Piece.new( board, self, b[y][x], x, y, board.tile_size, board.tile_size )
          board.set p, x, y
        end
      end
      return board
  end
  
  def move board
    free_pieces = board.free_pieces
    piece = free_pieces.random
    moves = board.possible_moves(piece)
    return [piece.x, piece.y], moves.random    
  end
  
end
