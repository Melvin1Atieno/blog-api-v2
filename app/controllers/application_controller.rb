# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  def authenticate_request
    @current_user = authorize_request(request.headers)
    render json: {error: @errors}, status: 401 unless @current_user
  end
  
  
  def authorize_request(headers)
    token = http_auth_header(headers)
    decoded_auth_token = JsonWebToken.decode(token)
    @user = User.find(decoded_auth_token[:user_id]) rescue nil
  end

  def http_auth_header(headers)
    @errors={}
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      @errors[:token] = 'Missing token'
    end
  end
end
