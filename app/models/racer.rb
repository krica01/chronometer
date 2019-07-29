class Racer < ApplicationRecord
	belongs_to :race
	has_many :rz_records

  default_scope { order(id: :asc) }

	
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
			puts "display in results"
			puts rz.displayInResults
			if rz.displayInResults
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
				
							
		end


		total = 0
		array.sum do |s|
			
  			puts s
  			h, m, s = s.split(':').map(&:to_i)
  			total = total + 60*60*h + 60*m + s
		end
		
		

		

		puts total
		return Time.at(total).utc.strftime("%H:%M:%S") 
	
	end
	
	def display_name
		display = name
		if nickname.to_s.size > 0
			display += " - " + nickname.to_s
		end
		return display
	end
	
	def getRaceTime
		time = self.getRaceTimeSort 
		if time == "DNF" || time == "DNS"
			#return "-"
		end
	
		return time
	end

	
end
