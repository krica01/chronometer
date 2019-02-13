class Rz < ApplicationRecord
	has_many :RzRecords
	belongs_to :race
end
