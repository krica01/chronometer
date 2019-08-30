class AddRzTimeToRacers < ActiveRecord::Migration[5.2]
  def change
    add_column :racers, :race_time, :datetime
  end
end
