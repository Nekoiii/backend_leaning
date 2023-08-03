require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name:"aaa"
    )
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages
    p 'aaaaa' if @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = "a" * (User::NAME_LENGTH_MAX + 1)
    assert_not @user.valid?   
  end
  test "name should not be too short" do
    @user.name = "a" * (User::NAME_LENGTH_MIN - 1)
    assert_not @user.valid?
  end

end
