require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_users_create_url
    assert_response :success
  end

  test "should get login" do
    get api_v1_users_login_url
    assert_response :success
  end

  test "should get logout" do
    get api_v1_users_logout_url
    assert_response :success
  end

end
