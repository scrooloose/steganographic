require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  test "POST create when the user has already completed the challenge redirects" do
    user = FactoryGirl.create(:user)
    challenge = FactoryGirl.create(:challenge, :answer => "foo")
    resp = FactoryGirl.create(:response, :challenge => challenge, :user => user, :correct => true, :attempts => 1)

    incomplete_challenge = FactoryGirl.create(:challenge, :answer => "foo")

    sign_in(user)
    post :create, :answer => "foo", :challenge_id => challenge.id
    assert_redirected_to new_challenge_response_path(incomplete_challenge.id)
  end

end
