require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "#next_challenge" do
    should "return nil if there is no next challenge" do
      u = FactoryGirl.create(:user)
      assert_nil u.next_challenge
    end

    should "not return a challenge made by the same user" do
      u = FactoryGirl.create(:user)
      c = FactoryGirl.create(:challenge, :user => u)
      assert_nil u.next_challenge
    end
  end
end
