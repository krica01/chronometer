class Racer < ApplicationRecord
	belongs_to :Race
	has_many :RzRecords
	
	def getRzRecord(ids)
		self.RzRecords.each do |rzrecord|
			if rzrecord.rz_id == ids && rzrecord.racer_id == self.id
				return rzrecord
			end
		end
	end
	
	def getRzRecordTime(id)
		rzrecord = getRzRecord(id)
		if rzrecord.present?
			return rzrecord.rzTime
		else
			return ""
		end
		
	end
	
end
