# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def authenticated_user
    @user = create(:user)
    post authenticate_url, params: {data: {'type': 'user','attributes': {email: @user.email, password: @user.password }}},
    headers: {'Accept': 'application/vnd.api+json'}
    token = JSON.parse(response.body)
    return token, @user
  end
end
