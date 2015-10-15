require 'test_helper'

class HomeControllerControllerTest < ActionController::TestCase
  test "should get display_homepage" do
    get :display_homepage
    assert_response :success
  end

end
