# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_url
    assert_response :success
    # *problem: Don't know why if i use 'APP_NAME' here,
    # it can't successfully detect the error (it shouldn't have
    # passed the test, but it did).
    # But "APP_NAME" works (be able to detect the error).
    assert_select 'title', APP_NAME
  end
end
