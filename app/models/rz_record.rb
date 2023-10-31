class RzRecord < ApplicationRecord
	belongs_to :rz
	belongs_to :racer

	belongs_to :race

	default_scope { order(id: :asc) }


	def self.startRzRecord(rz, racer, time)

		rzRecord = RzRecord.find_by(:racer_id => racer.id, :rz_id => rz.id)

		if !rzRecord.present?
			rzRecord = RzRecord.new
			rzRecord.rz = rz
			rzRecord.racer = racer
		end

		if !rzRecord.startTime.present?
			if rzRecord.finishTime.present?
				startT = Time.strptime(time, '%d/%m/%Y %H:%M:%S:%L')
				if startT >= rzRecord.finishTime
					puts "XXXXX ERROR"
					rzRecord.error_cd = 1
					racer = rzRecord.racer
					racer.error_cd = 1
					racer.save

				end
			end
			rzRecord.startTime = Time.strptime(time, '%d/%m/%Y %H:%M:%S:%L')
		end

		if rzRecord.startTime.present? && rzRecord.finishTime.present?
			rzRecord.rz_time = Time.at(rzRecord.finishTime - rzRecord.startTime).utc
			rzRecord.getRzTimeString
		end

		return rzRecord
	end

	def self.finishRzRecord(rz, racer, time)
		rzRecord = RzRecord.find_by(:racer_id => racer.id, :rz_id => rz.id)

		if !rzRecord.present?
			rzRecord = RzRecord.new
			rzRecord.rz = rz
			rzRecord.racer = racer
		end

		if !rzRecord.finishTime.present?
			rzRecord.finishTime = Time.strptime(time, '%d/%m/%Y %H:%M:%S:%L')
		end

		if rzRecord.startTime.present? && rzRecord.finishTime.present?
			rzRecord.rz_time = Time.at(rzRecord.finishTime - rzRecord.startTime).utc
			rzRecord.getRzTimeString
		end

		rzRecord.race = rz.race

		return rzRecord
	end

	def getRzTimeString
		if !self.rzTimeString.present?
			self.rzTimeString = Time.at(self.finishTime - self.startTime).utc.strftime("%H:%M:%S:%L")
		end

		return rzTimeString
	end

	def rzTime
		if self.startTime.present? && self.finishTime.present?
			return getRzTimeString
		elsif self.startTime.present? && !self.finishTime.present?
			return "-"
		elsif !self.startTime.present?
			return "-"
		end
	end

	def rzTimeSort
		if self.startTime.present? && self.finishTime.present?
			return getRzTimeString
		elsif self.startTime.present? && !self.finishTime.present?
			return "DNF"
		elsif !self.startTime.present?
			return "DNS"
		end
	end

	def showLastLive(race_id)
		rzRecords = RzRecord.find_by(:race_id => race_id)
	end

	def inError
		return self.error_cd != 0
	end

end
