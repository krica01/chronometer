class AddRzTimeStringToRzRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :rz_records, :rzTimeString, :string
  end
end
