class CreateRzRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :rz_records do |t|
      t.belongs_to :rz, index: true
      t.belongs_to :racer, index: true
      t.datetime :startTime
      t.datetime :finishTime

      t.timestamps
    end
  end
end
