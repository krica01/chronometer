class Race < ApplicationRecord
	has_many :racers
	has_many :rzs
end
