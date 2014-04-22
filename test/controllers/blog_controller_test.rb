require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  test "should get listbyuser" do
    get :listbyuser
    assert_response :success
  end

end
