require 'test_helper'
class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  
  test 'should authenticate registered user' do
    @registered_user = create(:user)
    post authenticate_url, params: {data: {'type': 'user','attributes': {email: @registered_user.email, password: @registered_user.password }}},
    headers: {'Accept': 'application/vnd.api+json'}
    assert_response :success
  end
end