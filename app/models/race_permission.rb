class RacePermission < ApplicationRecord
	belongs_to :race
	belongs_to :user
end
