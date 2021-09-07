require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", 
                                         email: "test@test",
                                         password: "123", 
                                         password_confirmation: "456" } }
    end
    assert_template "new"
    assert_select "div.error-list"
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example", 
                                         email: "test@test.com",
                                         password: "123456", 
                                         password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template "show"
    assert_not flash.empty?
    assert_select 'div.flash-message'
    assert is_logged_in?
  end
end
