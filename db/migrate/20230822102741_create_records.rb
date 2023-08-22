class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.references :machine, null: true, foreign_key: true

      t.string "title"
      t.string "content"
      t.integer "record_type"
      t.integer "record_status"
      t.timestamps
    end
  end
end
