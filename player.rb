

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
  def intialize name=:computer
    super(name, :human)
  end
end
