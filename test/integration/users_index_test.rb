require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user_1)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path, params: { per_page: 10 }
    assert_template 'users/index'

    if User.all.count > 10
      assert_select 'div.pagination'
    else
      assert_select 'div.pagination', count: 0
    end
    
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
