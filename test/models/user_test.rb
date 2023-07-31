require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name:"user_1_name"
    )
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages
  end


end
