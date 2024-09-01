require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'create' do
    assert Location.create! name: 'Test'
    refute Location.new(name: 'Test').valid?
  end

  test 'requires name' do
    location = Location.new
    refute location.valid?

    location.name = 'Test'
    assert location.valid?
  end
end
