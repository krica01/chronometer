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
		totalms = 0
		
		array.sum do |s|
			
  			h, m, s, l = s.split(':').map(&:to_i)
  			total = total + 60*60*h + 60*m + s
  			if !l.nil?
  				totalms = totalms + l
  			end
  			if totalms > 999
  				total = total + 1
  				totalms = totalms - 1000
  			end

		end
		
		

		
		puts 'getRaceTimeSort'
		puts total
		
		totalTime = Time.at(total).utc.strftime("%H:%M:%S") 
		
		return totalTime + ':' + totalms.to_s 
	
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


	def calculateRaceTime(rzCount)
		puts 'calculateRaceTime'
		puts rzCount
		rzRecordsCount = RzRecord.where(:racer_id => self.id).where.not(:rz_time => nil).count
		

		if rzRecordsCount < rzCount
			puts 'not finished all'
			return nil
		end 
		
		array = []
		

		self.rz_records.each do |rzRecord|
			puts 'rzRecord.rzTimeaa: ' + rzRecord.rzTimeString.to_s
			
			array << rzRecord.rzTimeString
			
		end
		
		total = 0
		totalms = 0
		
		array.sum do |s|
			

  			h, m, s, l = s.split(':').map(&:to_i)
  			total = total + 60*60*h + 60*m + s
  			if !l.nil?
  				totalms = totalms + l


  			end


		end
		

		totalTime = Time.at(total).utc.strftime("%H:%M:%S") 
		
		self.race_time_string = totalTime + ':' + totalms.to_s.rjust(3,'0') 
		
		self.save
	end
	
end
