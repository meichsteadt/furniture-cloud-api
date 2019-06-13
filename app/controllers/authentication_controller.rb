class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request
 # skip_before_action :check_keys

 def authenticate
   command = AuthenticateUser.call(user_params[:email], user_params[:password])

   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 def authenticate_site
   command = CheckKeys.call(auth_params[:user_key], auth_params[:user_secret])
   if command.success?
     render json: { auth_token: command.result, name: User.find(JsonWebToken.decode(command.result)["user_id"]).name}
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 private
  def user_params
    params.permit(:email, :password)
  end

  def auth_params
    params.require(:authentication).permit(:user_key, :user_secret)
  end
end
