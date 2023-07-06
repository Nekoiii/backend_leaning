class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    
    #remove_column :machines, :record_ids
       '''create_table :users do |t|
      t.string :name

      t.timestamps'''
    end
  end
end
