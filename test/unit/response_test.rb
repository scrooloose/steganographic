require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  test "it adds an unlock token when initialized" do
    r = FactoryGirl.build(:response)
    assert_not_nil r.unlock_token
  end
end
