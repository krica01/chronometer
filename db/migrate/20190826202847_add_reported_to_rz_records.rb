class AddReportedToRzRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :rz_records, :reported, :boolean
    add_column :rz_records, :finished, :boolean
  end
end
