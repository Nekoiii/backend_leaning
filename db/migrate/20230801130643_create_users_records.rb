class CreateUsersRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :users_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :record, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
