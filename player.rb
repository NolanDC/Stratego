

class Player
  def initialize owner
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
