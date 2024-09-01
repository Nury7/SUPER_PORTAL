require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test 'create' do
    assert Feature.create! name: 'Test'
    refute Feature.new(name: 'Test').valid?
  end

  test 'requires name' do
    feature = Feature.new
    refute feature.valid?

    feature.name = 'Test'
    assert feature.valid?
  end
end
