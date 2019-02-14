class CreateRacers < ActiveRecord::Migration[5.2]
  def change
    create_table :racers do |t|
      t.belongs_to :race, index: true
      t.integer :number
      t.string :name
      t.timestamps
    end
  end
end
