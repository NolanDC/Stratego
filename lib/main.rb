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
$pieces = %w{2 3 4 5 6 7 8 9 10 s b f}

hide_window= ARGV[0]

class GameWindow < Gosu::Window
  GAME_PHASES=[:setup, :play]
  
	def initialize
		super(800, 600, false)
		self.caption = "Stratego"
		
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



$game_window.show if !hide_window
