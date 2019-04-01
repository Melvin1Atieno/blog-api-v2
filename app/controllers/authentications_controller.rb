class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    @token = authenticate_user(auth_params[:attributes][:email], auth_params[:attributes][:password])
    if !@token.nil?
      render json: { auth_token: @token }, status: 200
    else
      render json: { error: @errors }, status: 401
    end
  end

  
  def authenticate_user(email, password )
    @errors = {}
    user = User.find_by(email: email)
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
