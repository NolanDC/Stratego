
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
    msg = Notification.new(@window, message, @x, @y+@title_height, @width, 25, color)
    @message_queue << msg
  end
  
  def add_move_object mo
    msg = MoveNotification.new(@window, mo, @x, @y+@title_height, @width, 60)
    @message_queue << msg
  end
  
  def message_start
    return @y+@title_height
  end
  
  def update
    #return if @messages.empty? && @message_queue.empty?
    @messages.each do |msg|    
      if !@message_queue.empty?
        msg.y += @message_queue.first.height/15

        if @messages.last.y >= @message_queue.first.height + message_start
          @messages << @message_queue.shift
        end      
      end
      if msg.y > @window.height
        @messages.delete(msg)
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
  Padding = 3
  def initialize window, message, x, y, width = 150, height = 25, color = Gosu::Color::WHITE
    @message = message
    @width = width
    @height = height
    super(window, x, y, color)
  end
  
  def draw
    @color.alpha = 150  
    @window.draw_rect(@x, @y, @width, @height - 5, @color) 

    @default_font.draw(@message, @x+3, @y+3, 0, 1, 1, Gosu::Color::BLACK)
    @color.alpha = 255
  end
end


class MoveNotification < Notification
  def initialize(window, move_object, x, y, width = 150, height = 60, color = Gosu::Color::WHITE)
    @window = window
    @move_object = move_object
    @width = width
    @height = move_object.piece.height + Padding*2
    if move_object.winning_player
      color = move_object.winning_player.color.copy
    end
    @window, @x, @y, @color = window, x, y, color
  end
  
  def draw
    @color.alpha = 50
    @window.draw_rect(@x, @y, @width, @height, @color)
    @color.alpha = 255
    
    if [:win, :loss].include?(@move_object.type)    
      left_piece = @move_object.winning_piece
      right_piece = @move_object.losing_piece
    else
      left_piece = @move_object.piece
      right_piece = @move_object.enemy
    end

    left_piece.draw Hash[:x => @x+Padding, :y => @y + Padding]
    right_piece.draw Hash[:x => @x + @width - Padding - @move_object.piece.width, :y => @y + Padding]

  end
end
  
