require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @course = courses(:ror)
  end

  test 'should get search' do
    visit(courses_search_path)
    page.has_content?("Login")
    page.has_no_content?("Profile")
    page.has_no_content?("Logout")
    fill_in "query", with: "Ruby on Rails"
    click_button
    contains_course @course
  end

  test 'search should get course' do
    log_in_as_capy(@user)
    visit(courses_search_path(query: "mitterdorfer"))
    contains_course @course
  end

  test '(un)favorite from search should work' do
    log_in_as(@user)
    assert_empty @user.courses
    put courses_favorite_path(tiss_id: @course.tiss_id, type: "favorite")
    assert_not_empty @user.courses
    assert_equal @course.title, @user.courses.first.title
    put courses_favorite_path(tiss_id: @course.tiss_id, type: "unfavorite")
    assert_empty @user.courses
  end

  test 'show users favorites' do
    log_in_as_capy(@user)
    put courses_favorite_path(tiss_id: @course.tiss_id, type: "favorite")
    visit(user_path(@user))
    contains_course @course
    log_out
    log_in_as_capy(@other)
    visit(user_path(@user))
    contains_course @course
  end

  test 'show course details (not logged in)' do
    visit(courses_path(@course))
    contains_course @course
  end

  test 'show course details (logged in)' do
    log_in_as_capy(@user)
    visit(courses_path(@course))
    contains_course @course
  end

  private

  def contains_course(course)
    page.has_content?(course.title)
  end
end
