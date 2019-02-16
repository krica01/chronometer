class Rz < ApplicationRecord
	has_many :RzRecords
	belongs_to :Race

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
		return self.RzRecords.sort { |a,b| a.rzTime <=> b.rzTime }
	end
	
end
