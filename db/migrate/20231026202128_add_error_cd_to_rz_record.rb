class AddErrorCdToRzRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :rz_records, :error_cd, :integer, default: 0
  end
end
