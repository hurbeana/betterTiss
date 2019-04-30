require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get courses_show_url
    assert_response :success
  end

  test "should get search" do
    get courses_search_url
    assert_response :success
  end

end
