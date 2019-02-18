class Racer < ApplicationRecord
	belongs_to :race
	has_many :rz_records

	
	def getRzRecord(ids)
		self.rz_records.each do |rzrecord|
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
