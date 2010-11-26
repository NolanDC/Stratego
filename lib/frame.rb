class Frame #Basic class for holding GUI elements

  def initialize window
    @objects = Array.new()
    @window = window
  end
  
  def draw
    return if @objects.nil?
    @objects.each do |o|
      o.draw
    end
  end
  
  def add render_object
    @objects << render_object
  end
  
end


class StartingFrame < Frame
  
  def initialize window
    super(window)
    @new_game = Button.new(Rectangle.new(window,200,200,100,50, Gosu::Color::RED), "New Game")
    add @new_game
  end

  def start_game?
    return @new_game.down?
  end
  
end