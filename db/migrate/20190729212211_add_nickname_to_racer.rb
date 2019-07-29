class AddNicknameToRacer < ActiveRecord::Migration[5.2]
  def change
    add_column :racers, :nickname, :string
  end
end
