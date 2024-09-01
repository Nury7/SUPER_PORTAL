class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.boolean :published, null: false, default: false
      t.string :title, null: false
      t.string :description, null: false
      t.string :external_id, null: false, unique: true
      t.integer :bedrooms
      t.integer :bathrooms
      t.references :location, null: false
      t.timestamps
    end
  end
end
