class Initialization2 < ActiveRecord::Migration[7.0]
  def change
    """create_table :users do |t|
      t.string :name

      t.timestamps
    end
    create_table :records do |t|
      t.string :title
      t.string :content
      #t.enum :type,  enum_name: :record_enum_type
      t.string :image_url

      t.references :user, foreign_key: true
      t.references :machine, foreign_key: true

      t.timestamps
    end
    create_table :machines do |t|
      t.string :name

      t.timestamps
    end"""

    #add_reference :records, :user, foreign_key: true
    #add_reference :records, :machine, foreign_key: true
  end
end
