require 'test_helper'

class EasyBrokerSynchronizerTest < ActiveSupport::TestCase
  test 'synchronize' do
    assert_raises NotImplementedError do
      EasyBrokerSynchronizer.synchronize
    end
  end
end
