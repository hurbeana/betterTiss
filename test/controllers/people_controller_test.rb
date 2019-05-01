# frozen_string_literal: true

require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @person = people(:mitterdorfer)
  end

  test 'should get search' do
    visit(people_search_path)
    page.has_content?("Login")
    page.has_no_content?("Profile")
    page.has_no_content?("Logout")
    fill_in "query", with: "Ruby on Rails"
    click_button
    contains_person @person
  end

  test 'search should get person' do
    log_in_as_capy(@user)
    visit(people_search_path(query: "Ruby on Rails"))
    contains_person @person
  end

  test '(un)favorite from search should work' do
    log_in_as(@user)
    assert_empty @user.people
    put people_favorite_path(tiss_id: @person.tiss_id, type: "favorite")
    assert_not_empty @user.people
    assert_equal @person.firstname, @user.people.first.firstname
    put people_favorite_path(tiss_id: @person.tiss_id, type: "unfavorite")
    assert_empty @user.people
  end

  test 'show users favorites' do
    log_in_as_capy(@user)
    put people_favorite_path(tiss_id: @person.tiss_id, type: "favorite")
    visit(user_path(@user))
    contains_person @person
    log_out
    log_in_as_capy(@other)
    visit(user_path(@user))
    contains_person @person
  end

  test 'show person details (not logged in)' do
    visit(people_path(@person))
    contains_person @person
  end

  test 'show person details (logged in)' do
    log_in_as_capy(@user)
    visit(people_path(@person))
    contains_person @person
  end

  private

  def contains_person(person)
    page.has_content?(person.lastname)
    page.has_content?("Gender: #{person.gender}")
    page.has_selector?('img')
    page.has_content?("a[href=#{people_path(person)}")
    page.has_content?("a[href=#{people_favorite_path(tiss_id: person.tiss_id, type: "favorite")}")
  end

end
