require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  test "should get listbyuser" do
    get :listbyuser
    assert_response :success
  end

end
