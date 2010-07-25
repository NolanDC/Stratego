
class NotificationHandler < RenderObject
  def initialize window, x, y, width = 150
    @title_height = 100
    @width = width
    @messages = [Notification.new(window, "Welcome to Stratego!", x, y+@title_height+5, width)]
    @message_queue = []
    @target_height = 0
    super(window, x, y)
    #add "Welcome to the game!"
  end
  
  def add message, color = Gosu::Color::BLACK
    @message_queue << Notification.new(@window, message, @x, @y+@title_height-20, @width, 25, color)
    @target_height += 25
  end
  
  def add_move_object mo
    
    col = Gosu::Color::BLACK
    col = mo.winning_player.color if mo.winning_player
    @message_queue << Notification.new(@window, mo.message, @x, @y+@title_height-20, @width, 25, col)
    @target_height += 25
  end
  
  def update
    if @target_height <= @message_queue.size*25
      if !@message_queue.empty?
        @messages << @message_queue.shift
      end
    end
    
    if @target_height > 0
      @target_height -= 5
      @messages.each do |msg|
        msg.y += 5
      end
    end
  end
  
  def draw
    @messages.each do |msg|
      msg.draw
    end
    @window.draw_rect @x, @y, @width, @title_height    
  end
end

class Notification < RenderObject
  def initialize window, message, x, y, width = 150, height = 25, color = Gosu::Color::WHITE
    @message = message
    @width = width
    @height = height
    super(window, x, y, color)
  end
  
  def draw
    @color.alpha = 150  
    @window.draw_rect(x, y, width, height - 5, @color) 

    @default_font.draw(@message, x+3, y+3, 0, 1, 1, Gosu::Color::WHITE)
    @color.alpha = 255
  end
end
