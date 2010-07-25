

class Stratego
	PIECE_COUNT={:flag => 1, :bomb => 6, :spy => 1, :scout => 8, :miner => 5, :sergeant => 4, :leut => 4,
					:captain => 4, :major => 3, :colonel => 2, :general => 1, :marshal => 1}

	SYMBOLS={:flag => 'f', :bomb => 'b', :spy => 's', :scout => '2', :miner => '3', :sergeant => '4', :leut => '5',
					:captain => '6', :major => '7', :colonel => '8', :general => '9', :marshal => '10'}
	
	PIECE_ARRAY= [:flag, :bomb, :spy, :scout, :miner, :sergeant, 
	              :leut, :captain, :major, :colonel, :general, :marshal]
  MOVE_HASH={:flag => 0, :bomb => 0, :spy => 1, :scout => 10, :miner => 1, :sergeant => 1,
   :leut => 1, :captain => 1, :major => 1, :colonel => 1, :general => 1, :marshal => 1}	              
	def self.count? sym
		return PIECES[sym]
	end

	def self.pieces
		return PIECE_COUNT.keys
	end
	
	def self.short sym
	  return SYMBOLS[sym]
	end
	
	def self.can_move? sym
	  return MOVE_HASH[sym] > 0 ? true : false
	end
	
	LOSE_HASH = {
	  :scout => [:bomb, :miner, :sergeant, :leut, :captain, :major, :colonel, :general, :marshal],
	  :miner => [:sergeant, :leut, :captain, :major, :colonel, :general, :marshal],
	  :seargeant => [:bomb, :leut, :captain, :major, :colonel, :general, :marshal],
	  :leut => [:bomb, :captain, :major, :colonel, :general, :marshal],
	  :captain => [:bomb, :major, :colonel, :general, :marshal],
	  :major => [:bomb, :colonel, :general, :marshal],
	  :colonel => [:bomb, :general, :marshal],
	  :general => [:bomb, :marshal],
	  :marshal => [:bomb, :spy],
	  :spy => PIECE_ARRAY,
	  :bomb => [:miner],
	  :flag => PIECE_ARRAY
	  }

	WIN_HASH = {
	  :scout => [:flag],
	  :miner => [:scout, :bomb, :flag],
	  :sergeant => [:flag, :spy, :scout, :miner],
	  :leut => [:flag, :spy, :scout, :miner, :sergeant],
	  :captain => [:flag, :spy, :scout, :miner, :sergeant, :leut],
	  :major => [:flag, :spy, :scout, :miner, :sergeant, :leut, :captain],
	  :colonel => [:flag, :spy, :scout, :miner, :sergeant, :leut, :captain, :major],
	  :general => [:flag, :spy, :scout, :miner, :sergeant, :leut, :captain, :major, :colonel],
	  :marshal => [:flag, :spy, :scout, :miner, :sergeant, :leut, :captain, :major, :colonel, :general],
	  :spy => [:marshal],
	  :bomb => [:miner],
	  :flag => PIECE_ARRAY
	  }	  
end


