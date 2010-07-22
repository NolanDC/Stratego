require 'rubygems'
require 'gosu'
require 'extensions'
require 'render_object'
require 'board'
require 'piece_placer'
require 'rect'
require 'stratego'
require 'piece'
require 'button'
$pieces = %w{2 3 4 5 6 7 8 9 10 s b f}


class GameWindow < Gosu::Window
	def initialize
		super(800, 600, false)
		self.caption = "Gosu Tutorial Game"
		@board = GameBoard.new self
		
		@mouse = Rectangle.new(self, 1, 1, 3, 3)
		@mouse.color = Gosu::Color::RED

		@exit = Button.new(Rectangle.new(self, 0, 0, 400, 400))
	end

	def update
	  @board.update
	end

	def draw
		@mouse.x = self.mouse_x
		@mouse.y = self.mouse_y
		@board.draw
		@mouse.draw		
	end
end

def window
	return $game_window
end

$game_window = GameWindow.new



$game_window.show
