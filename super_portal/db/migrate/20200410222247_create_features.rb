class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end

    create_table :features_properties, id: false do |t|
      t.belongs_to :property, null: false
      t.belongs_to :feature, null: false
    end
  end
end
