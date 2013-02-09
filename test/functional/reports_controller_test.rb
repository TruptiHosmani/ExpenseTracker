require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get top_spenders" do
    get :top_spenders
    assert_response :success
  end

end
