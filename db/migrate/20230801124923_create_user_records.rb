class CreateUserRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :user_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
