class Racer < ApplicationRecord
	belongs_to :Race
	has_many :RzRecords
	
	def getRzRecord(id)
		self.RzRecords.each do |rzrecord|
			if rzrecord.id == id
				return rzrecord
			end
		end
	end
	
	def getRzRecordTime(id)
		rzrecord = getRzRecord(id)
		if rzrecord[0].present?
			return rzrecord[0].rzTime
		else
			retunr ""
		end
		
	end
	
end
