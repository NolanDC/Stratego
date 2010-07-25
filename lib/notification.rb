
class NotificationHandler < RenderObject
  def initialize window, x, y, width = 150
    @title_height = 100
    @width = width
    @messages = []
    @message_queue = []
    @target_height = 0
    super(window, x, y)
    add "Welcome to the game!"
  end
  
  def add message
    @message_queue << Notification.new(@window, message, @x, @y+@title_height+5, @width)
    @target_height += 25
  end
  
  def update
    if @target_height <= 0
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
    @window.draw_rect @x, @y, @width, @title_height
    @messages.each do |msg|
      msg.draw
    end
  end
end

class Notification < RenderObject
  def initialize window, message, x, y, width = 150, height = 25
    @message = message
    @width = width
    @height = height
    super(window, x, y)
  end
  
  def draw
    @window.draw_rect(x, y, width, height - 5) 
    @default_font.draw(@message, x+3, y+3, 0, 1, 1, Gosu::Color::BLACK)
  end
end
