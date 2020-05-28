class CreateRacePermissions < ActiveRecord::Migration[5.2]
  def up
    create_table :race_permissions do |t|
      t.integer :race_id
      t.integer :user_id

      t.timestamps
    end
  end
  
  def down
  	drop_table :race_permissions
  end
  
end
