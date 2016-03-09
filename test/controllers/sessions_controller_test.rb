require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
	
	test "should create user" do
		assert_no_difference('User.count') do
			post :create, email = params['abfs@aiesec.net'], senha = params['abfs@aiesec.net']
		end
		assert_redirected_to authentication_login
	end
end
