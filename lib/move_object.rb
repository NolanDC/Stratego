

class MoveObject
  attr_accessor :type, :piece, :enemy, :player
  MOVE_TYPES=[:move, :win, :loss, :suicide]
  
  def initialize type, player, piece, enemy = nil
    @type = type
    @piece = NotificationPiece.from_piece(piece)

    @enemy = NotificationPiece.from_piece(enemy) if enemy
    @player = player
  end
  
  def message
    pstr = "#{@piece.symbol.to_s.capitalize}(#{Stratego.short(@piece.symbol)})"
    
    if @enemy
      estr = "#{@enemy.symbol.to_s.capitalize}(#{Stratego.short(@enemy.symbol)})"
    end
    
    case type
      when :move
        return ""
      when :win
        return "#{pstr} #{['killed', 'murdered', 'destroyed'].random} #{estr}"
      when :loss
        return "#{pstr} #{['lost to', 'submitted to', 'was killed by'].random} #{estr}"      
      when :suicide
        return "#{pstr} and #{estr} #{['offed each other', 'blew up'].random}"
    end
  end
  
  def winning_piece
    if @type == :loss
      return @enemy
    elsif @type == :win
      return @piece
    else
      return nil
    end
  end
  
  def losing_piece
    if @type == :loss
      return @piece
    elsif @type == :win
      return @enemy
    else
      return nil
    end
  end
  
  def winning_player
    if @type == :loss
      return @enemy.player
    elsif @type == :win
      return @piece.player
    else
      return nil
    end
  end
  
  def losing_player
    if @type == :loss
      return @piece.player
    elsif @type == :win
      return @enemy.player
    else
      return nil
    end
  end
end
