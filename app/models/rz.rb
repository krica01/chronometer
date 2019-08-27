class Rz < ApplicationRecord
	has_many :rz_records 
	belongs_to :race
	
	default_scope { order(id: :asc) }


	def self.isRacerStarted(rzId, racerId)
		res = false
		
		rzRecord = RzRecord.find_by(:rz_id => rzId, :racer_id => racerId)
		
		if rzRecord.present? && rzRecord.startTime.present?
			res = true
		end
	
		return res

	end
	
	
	def self.isRacerFinished(rzId, racerId)
		res = false
		
		rzRecord = RzRecord.find_by(:rz_id => rzId, :racer_id => racerId)
		
		if rzRecord.present? && rzRecord.finishTime.present? 
			res = true
		end
	
		return res

	end
	
	
	def evalRzTimes
		return self.rz_records.sort { |a,b| a.rzTimeSort <=> b.rzTimeSort }
	end
	
	def displayInResults
		racerFinished = false
		self.race.racers.each do |racer|
			if Rz.isRacerFinished(self.id, racer.id)
				racerFinished = true
			end
			
		end
		
		return racerFinished
	end
	
	def getLiveRzRecords
		liveRR = RzRecord.where(:rz_id => self.id).where('rzTimeString is not null').reorder('finishTime desc')
		
		return liveRR 
	
	end
	
end
