class AddRzTimeToRzRecords < ActiveRecord::Migration[5.2]
  def up
     add_column :rz_records, :field_name, :timestamp
  end

  def down
  	remove_column :rz_records, :field_name
    
  end
end
