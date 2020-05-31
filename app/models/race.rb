class Race < ApplicationRecord
	has_many :racers
	has_many :rzs
	has_many :rz_records
	has_many :race_permissions
	
	  default_scope { order(id: :asc) }
	
	def evalRaceTimes
		return self.racers.sort { |a,b| a.getRaceTimeSort <=> b.getRaceTimeSort }
	end

	def getOveralResults
		rzCount = self.rzs.count


		self.racers.each do |racer|

			if racer.race_time_string.nil?

				racer.calculateRaceTime(rzCount)
			end
		end
	
		return Racer.where(:race_id => self.id).where.not(:race_time_string => nil).reorder('race_time_string asc')
	

	end
	
	def self.getContributingRaces(user_id)
		racePermissions = []
		racePermissions << RacePermission.find_by(:user_id => user_id)
		races = []
		racePermissions.each do |rp|
			if !rp.nil?
				races << rp.race
			end
		end
		
		return races
		
	end

	
end
