require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user_1)
  end

end

"""
Minitest runs all classes ending in ’Test' as tests; classes not ending in 'Test'
won't run unless explicitly invoked. Therefore, classes with only a setup method 
shouldn't end in ‘Test’ to avoid running only the setup without any tests.
"""
class InvalidPasswordTest < UsersLogin  
  test "login path" do
    get login_path
    assert_template 'sessions/new'
  end
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end


class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
  end
end

class RememberingTest < UsersLogin
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
    # Use assigns() to access the @user instance variable set in the controller.
    # assigns: https://stackoverflow.com/questions/8616508/what-does-assigns-do-in-ruby-on-rails
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end

  # Verify that the cookie has been deleted before logging in
  test "login without remembering" do
    log_in_as(@user, remember_me: '1')
    log_in_as(@user, remember_me: '0')
    #* Can't use .empty? here because it will raise err when nil
    assert cookies[:remember_token].blank?
  end
end

class ValidLoginTest < ValidLogin
  test "valid login" do
    assert is_logged_in?
    assert_redirected_to @user
  end
  test "redirect after login" do
    # follow_redirect: https://loveenglish.hatenablog.com/entry/2023/02/17/235730
    follow_redirect!
    # Check if the template rendered is 'users/show'.
    assert_template 'users/show'
    # Check for specific HTML elements in the rendered page
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end


class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test "successful logout" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "redirect after logout" do
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should still work after logout in second window" do
    # Simulate the user clicking on 'logout' in another browser
    delete logout_path 
    assert_redirected_to root_url
  end
end



