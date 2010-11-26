require 'rubygems'
require 'gosu'
require '../helpers/gosu_extensions'
require 'game'
require 'mouse'
require '../helpers/extensions'
require '../helpers/count_hash'
require 'render_object'
require 'board'
require 'piece_placer'
require 'rect'
require 'stratego'
require 'piece'
require 'button'
require 'player'
require 'notification'
require 'move_object'
require 'frame'
# one liner, maybe? ['rubygmems', 'gosu', '../helpers/gosu_extensions', 'mouse']
$pieces = %w{2 3 4 5 6 7 8 9 10 s b f}

hide_window= ARGV[0]

class GameWindow < Gosu::Window
  attr_accessor :mouse
  GAME_PHASES=[:menu, :setup, :play]
  
	def initialize
		super(800, 600, false)
		self.caption = "Stratego"
		@mouse = Mouse.new self
		@game = Game.new self
    @background = Rectangle.new(self,0,0,self.width,self.height)
	end

	def update
	  @mouse.update
    @game.update
	end

	def draw
	  @background.draw
    @game.draw
	end

end
$game_window = GameWindow.new



$game_window.show if !hide_window
