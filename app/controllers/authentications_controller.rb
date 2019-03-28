class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request

  def authentication_token
    @token = authenticate_user(auth_params)
    if !@auth_token.nil?
      render json: { auth_token: @auth_token }, status: 200
    else
      render json: { error: @errors }, status: 401
    end
  end

  
  def authenticate_user
    @errors = {}
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return JsonWebToken.encode(user_id: user.id)
    else
      @errors[:user_authentication] = 'Invalid credentials'
      return nil
    end
  end

  private
  
  def auth_params
        params.require(:data).permit(attributes:[:password, :email])
  end
end