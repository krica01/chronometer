class AddUserIdToRzs < ActiveRecord::Migration[5.2]
  def change
    add_column :rzs, :user_id, :integer
  end
end
