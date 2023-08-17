require "test_helper"

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:test_user_1)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    # Not important but use this order '@user, current_user' instead of
    # 'current_user, @user' here it's because we usually use assert_equal as :
    # assert_equal <期待する値>, <実際の値>
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
