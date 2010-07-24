

class Mouse
  BUTTONS={:left => Gosu::MsLeft, :right => Gosu::MsRight}

  def initialize window
    @window = window
    @down = {:left => false, :right => false}
    @hit = {:left => false, :right => false}
    @hit_last = Hash.new.merge(@hit)
  end
  
  def update
    BUTTONS.each_key do |btn|
      @hit_last[btn] = @hit[btn]    
      if @window.button_down?(BUTTONS[btn])
        @hit[btn] = true
        @down[btn] = true
      else
        @hit[btn] = false
        @down[btn] = false
      end
    end
  end
  
  def hit? btn
    if @hit_last[btn] == false && @hit[btn] == true
      return true
    end
    return false
  end
  
  def down? btn
    return @down[btn]
  end
end


