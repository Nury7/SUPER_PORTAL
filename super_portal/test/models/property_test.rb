require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  test 'validations' do
    property = Property.new
    refute property.valid?
    [:title, :description, :location, :external_id].each do |attribute|
      assert property.errors.has_key?(attribute)
    end

    property.external_id = properties(:simpson_house).external_id
    property.valid?
    assert property.errors.has_key?(:external_id)

    property.external_id = 'EB-123'
    property.valid?
    refute property.errors.has_key?(:external_id)
  end

  test 'create' do
    property = Property.new
    property.title = 'Cool House'
    property.description = 'Super description of cool house'
    property.external_id = 'EB-123'
    property.bedrooms = 2
    property.bathrooms = 1
    property.location = locations(:condesa)
    assert property.save
  end

  test 'features' do
    house = properties(:simpson_house)
    house.features << features(:pool)
    house.features << features(:balcony)
    house.save
    assert_equal 2, house.features.count
  end
end
