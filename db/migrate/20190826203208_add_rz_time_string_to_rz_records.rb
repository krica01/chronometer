class AddRzTimeStringToRzRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :rz_records, :rz_time_string, :string
  end
end
