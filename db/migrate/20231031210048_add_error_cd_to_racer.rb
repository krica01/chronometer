class AddErrorCdToRacer < ActiveRecord::Migration[5.2]
  def change
    add_column :racers, :error_cd, :integer
  end
end
