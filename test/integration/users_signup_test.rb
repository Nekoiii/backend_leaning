require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "xx@xxx",
                                         password: "xxxxxx",
                                         password_confirmation: "aaaaaa" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "AA",
                                         email: "aa@123.aa",
                                         password: "aaaaaa",
                                         password_confirmation: "aaaaaa" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?

  end
end
