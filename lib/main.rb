require 'rubygems'
require 'gosu'
require 'game'
require '../helpers/extensions'
require 'render_object'
require 'board'
require 'piece_placer'
require 'rect'
require 'stratego'
require 'piece'
require 'button'
require 'player'
$pieces = %w{2 3 4 5 6 7 8 9 10 s b f}


class GameWindow < Gosu::Window
  GAME_PHASES=[:setup, :play]
  
	def initialize
		super(800, 600, false)
		self.caption = "Gosu Tutorial Game"
		
		@game = Game.new self
	end

	def update
    @game.update
	end

	def draw
    @game.draw
	end

end
$game_window = GameWindow.new



$game_window.show
