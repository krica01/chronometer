class Race < ApplicationRecord
	has_many :racers
	has_many :rzs
	has_many :rz_records
	
	  default_scope { order(id: :asc) }
	
	def evalRaceTimes
		return self.racers.sort { |a,b| a.getRaceTimeSort <=> b.getRaceTimeSort }
	end

	
end
