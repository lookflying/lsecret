require 'test_helper'

class StatControllerTest < ActionController::TestCase
  test "should get average" do
    get :average
    assert_response :success
  end

  test "should get trend" do
    get :trend
    assert_response :success
  end

  test "should get zui" do
    get :zui
    assert_response :success
  end

end
