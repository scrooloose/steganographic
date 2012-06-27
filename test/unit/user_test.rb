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

  context "#completed_all_beginner_challenges?" do
    should "return false if the user has not completed all beginner challenges" do
      u = FactoryGirl.create(:user)
      b1 = FactoryGirl.create(:challenge, :for_beginners => true)
      assert_equal false, u.completed_all_beginner_challenges?
    end

    should "return true if the user has completed all beginner challenges" do
      u = FactoryGirl.create(:user)
      b1 = FactoryGirl.create(:challenge, :for_beginners => true)
      FactoryGirl.create(:response, :challenge => b1, :correct => true, :user => u)
      assert u.completed_all_beginner_challenges?
    end


  end

  context "#incomplete_beginner_challenges" do
    setup do
      @u_creator = FactoryGirl.create(:user)
      @u = FactoryGirl.create(:user)
      @b1 = FactoryGirl.create(:challenge, :user => @u_creator, :for_beginners => true)
      @b2 = FactoryGirl.create(:challenge, :user => @u_creator, :for_beginners => true)
      @not_b = FactoryGirl.create(:challenge, :user => @u_creator, :for_beginners => false)

    end

    should "return beginner challenge that havent been attempted" do
      FactoryGirl.create(:response, :challenge => @b1, :correct => true, :user => @u)
      assert @u.incomplete_beginner_challenges.include?(@b2)
    end

    should "not return any non-beginner challenges" do
      assert_equal false, @u.incomplete_beginner_challenges.include?(@not_b)
    end

    should "return beginner challenges that haven't been answered correctly" do
      FactoryGirl.create(:response, :challenge => @b1, :correct => true, :user => @u)
      incorrect_resp = FactoryGirl.create(:response, :challenge => @b2, :correct => false, :user => @u)
      assert @u.incomplete_beginner_challenges.include?(@b2)
    end

    should "not return challenges created by the same user" do
      c = FactoryGirl.create(:challenge, :user => @u, :for_beginners => true)
      assert_equal false, @u.incomplete_beginner_challenges.include?(c)
    end
  end
end
