class RecordsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get records_url
    assert_response :success
  end

end
