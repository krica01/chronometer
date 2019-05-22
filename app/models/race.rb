class Race < ApplicationRecord
	has_many :racers
	has_many :rzs
	
	def evalRaceTimes
		return self.racers.sort { |a,b| a.getRaceTimeSort <=> b.getRaceTimeSort }
	end

	
end
