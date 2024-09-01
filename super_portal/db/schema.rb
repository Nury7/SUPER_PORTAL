# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_03_194431) do

  create_table "features", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_features_on_name", unique: true
  end

  create_table "features_properties", id: false, force: :cascade do |t|
    t.integer "property_id", null: false
    t.integer "feature_id", null: false
    t.index ["feature_id"], name: "index_features_properties_on_feature_id"
    t.index ["property_id"], name: "index_features_properties_on_property_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.boolean "published", default: false, null: false
    t.string "title", null: false
    t.string "description", null: false
    t.string "external_id", null: false
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_properties_on_location_id"
  end

end
