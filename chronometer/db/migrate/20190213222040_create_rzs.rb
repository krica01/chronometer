class CreateRzs < ActiveRecord::Migration[5.2]
  def change
    create_table :rzs do |t|
      t.belongs_to :race, index: true
      t.string :name

      t.timestamps
    end
  end
end
