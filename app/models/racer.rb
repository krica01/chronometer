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
	
	def getRaceTimeSort

		array = []
		
		puts "RZS - userId" + self.id.to_s
		self.race.rzs.each do |rz|
				
				puts "RZ ID - " + rz.id.to_s
				
				rzRecord = self.getRzRecord(rz.id)			

				puts rzRecord
				
				if !rzRecord.present? || !rzRecord.startTime.present?
					totalTime = "DNS"
					return totalTime 
				end
				
				if !rzRecord.finishTime.present?
					totalTime = "DNF"
					return totalTime 
				end

				array << getRzRecordTime(rz.id)
				
				
							
		end


		total = 0
		array.sum do |s|
			
			puts 'aaaa'
  			puts s
  			h, m, s = s.split(':').map(&:to_i)
  			total = total + 60*60*h + 60*m + s
		end
		
		

		

		puts total
		return Time.at(total).utc.strftime("%H:%M:%S") 
	
	end
	
	
	def getRaceTime
		time = self.getRaceTimeSort 
		if time == "DNF" || time == "DNS"
			return "-"
		end
	
		return time
	end

	
end
