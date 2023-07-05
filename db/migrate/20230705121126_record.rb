class Record < ActiveRecord::Migration[7.0]
  def change
    add_column :records, :type, :string
    add_column :records, :machine, :string
    add_column :records, :image_url, :string
  end
end
