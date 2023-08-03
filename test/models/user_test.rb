require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name:"aaa"
    )
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages
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

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    return if @user.email.nil?
    
    duplicate_user = @user.dup
    # (Because email addresses are not case sensitive ) 
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

end
