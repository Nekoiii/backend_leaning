class AddMyTypeToRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :records, :record_type, :integer, default: nil
  end
end
