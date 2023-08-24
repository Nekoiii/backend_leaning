require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @activated_user = users(:test_user_1)
    @inactive_user  = users(:inactive_user_1)
    # puts "Activated user from fixtures: #{@activated_user.inspect}"
    # puts "Inactive user from fixtures: #{@inactive_user.inspect}" 
  end

  test "should redirect when user not activated" do
    get user_path(@inactive_user)
    # puts "aaaaaaaaa#{response.body}"
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should display user when activated" do
    # puts "Activated user from fixtures -2 : #{@activated_user.inspect}"
    get user_path(@activated_user)
    assert_response :success
    assert_template 'users/show'
  end
end
