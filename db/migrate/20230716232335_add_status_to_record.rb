class AddStatusToRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :records, :record_status, :integer
  end
end
