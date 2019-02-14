class Racer < ApplicationRecord
	belongs_to :race
	has_many :rzrecords
end
