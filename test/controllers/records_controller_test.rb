# frozen_string_literal: true

require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get records_url
    assert_response :success
  end

  test 'layout test' do
    get records_path
    assert_template 'records/index'
    assert_select 'a[href=?]', root_path, count: 1
    assert_select 'a[href=?]', users_path, count: 1
    assert_select 'h1', 'Records Page'
  end
end
