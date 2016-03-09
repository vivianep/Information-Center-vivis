require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "unsucessful login" do
    # login via https
    get "/authentication/login"
    assert_response :success
 
    post_via_redirect "/authentication/login", email: 'fulano@aiesec.net', password: '12345'

    assert_template "authentication/login"
  end

    
end
