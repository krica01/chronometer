class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name
      t.string :place
      t.datetime :date

      t.timestamps
    end
  end
end
