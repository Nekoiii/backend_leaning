class RemoveUserIdFromRecords < ActiveRecord::Migration[7.0]
  def change
    remove_column :records, :user_id
  end
end
