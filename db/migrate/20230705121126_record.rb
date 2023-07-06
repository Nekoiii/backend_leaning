class Record < ActiveRecord::Migration[7.0]
  def change
    
'''    delete_column :records, :machine
    add_column :records, :machine, Types::MachineType
    add_column :records, :user, Types::UserType

    add_column :records, :type, :string
    add_column :records, :user, :string
    add_column :records, :image_url, :string'''
  end
end
