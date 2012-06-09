require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  test "#correct_answer? strips out all whitespace when comparing" do
    c = FactoryGirl.build(:challenge, :answer => "foo bar baz")
    assert c.correct_answer?( "  foo bar baz  ")
  end

  test "#correct_answer? strips out non-alphanumeric chars when comparing" do
    c = FactoryGirl.build(:challenge, :answer => "foo bar baz")
    assert c.correct_answer?( 'foo!&^~@#bar))--++baz')
  end
end
