class AddRaceIdToRzRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :rz_records, :race_id, :integer
  end
end
