require "test_helper"

class UsersIndex < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:test_user_1)
    @non_admin = users(:test_user_2)
    # puts "Admin user from fixtures: #{@admin.inspect}"
    # puts "Non-admin user from fixtures: #{@non_admin.inspect}" 
  end
end

class UsersIndexAdmin < UsersIndex
  def setup
    super
    log_in_as(@admin)
    get users_path
  end
end

class UsersIndexAdminTest < UsersIndexAdmin
  test "should render the index page" do
    assert_template 'users/index'
  end

  test "should paginate users" do
    expected_count = User.all.count > USERS_PER_PAGE ? 1 : 0
    assert_select 'div.pagination', count: expected_count    
  end

  test "should have delete links" do
    first_page_of_users = User.where(activated: true)
                              .order(created_at: :desc)
                              .paginate(page: 1, per_page: USERS_PER_PAGE)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
  end

  test "should be able to delete non-admin user" do
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
    assert_response :see_other
    assert_redirected_to users_url
  end

  test "should display only activated users" do
    # Toggle activated
    User.where(activated: true)
        .order(created_at: :desc)
        .paginate(page: 1).first.toggle!(:activated)
    get users_path      
    assigns(:users).each do |user|
      assert user.activated?
    end
  end

  # test "index as admin including pagination and delete links" do
  #   log_in_as(@admin)
  #   get users_path, params: { per_page: 10 }
  #   assert_template 'users/index'

  #   expected_count = User.all.count > USERS_PER_PAGE ? 1 : 0
  #   assert_select 'div.pagination', count: expected_count    
    
  #   # User.order(created_at: :desc).paginate(page: 1, per_page: USERS_PER_PAGE).each do |user|
  #   #   assert_select 'a[href=?]', user_path(user), text: user.name
  #   # end

  #   first_page_of_users = User.order(created_at: :desc).paginate(page: 1, per_page: USERS_PER_PAGE)
  #   first_page_of_users.each do |user|
  #     assert_select 'a[href=?]', user_path(user), text: user.name
  #     unless user == @admin
  #       assert_select 'a[href=?]', user_path(user), text: 'delete'
  #     end
  #   end
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@non_admin)
  #     assert_response :see_other
  #     assert_redirected_to users_url
  #   end
  # end
end


class UsersNonAdminIndexTest < UsersIndex

  test "should not have delete links as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end