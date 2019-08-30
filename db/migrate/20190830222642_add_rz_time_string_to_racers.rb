class AddRzTimeStringToRacers < ActiveRecord::Migration[5.2]
  def change
    add_column :racers, :race_time_string, :string
  end
end
