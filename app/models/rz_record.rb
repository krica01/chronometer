class RzRecord < ApplicationRecord
	belongs_to :rz
	belongs_to :racer
	
		
	def self.startRzRecord(rz, racer, time)
		rzRecord = RzRecord.find_by(:racer_id => racer.id, :rz_id => rz.id)
		
		if !rzRecord.present? 
			rzRecord = RzRecord.new
			rzRecord.rz = rz
			rzRecord.racer = racer
		end
		
		rzRecord.startTime = Time.strptime(time, '%m/%d/%Y, %I:%M:%S %p')
		
		
		return rzRecord
	end
	
	def self.finishRzRecord(rz, racer, time)
		rzRecord = RzRecord.find_by(:racer_id => racer.id, :rz_id => rz.id)
		
		if !rzRecord.present? 
			rzRecord = RzRecord.new
			rzRecord.rz = rz
			rzRecord.racer = racer
		end
		
		rzRecord.finishTime = Time.strptime(time, '%m/%d/%Y, %I:%M:%S %p')
		
		
		return rzRecord
	end
	
end
