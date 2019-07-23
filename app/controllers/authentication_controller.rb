class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

 # skip_before_action :check_keys

 def authenticate
   command = AuthenticateUser.call(user_params[:email], user_params[:password])
   if command.success?
     token = command.result
     render json: { auth_token: token }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 def authenticate_site
   command = CheckKeys.call(auth_params[:url], auth_params[:secret])
   if command.success?
     token = command.result
     render json: { auth_token: command.result, store: Store.find(
        JsonWebToken.decode(command.result)["store_id"])
          .attributes.slice(
            "id",
            "name",
            "logo",
            "favicon",
            "yelp",
            "facebook",
            "instagram",
            "twitter",
            "google_reviews_id",
            "yellow_pages",
            "google_maps",
            "email",
          )
     }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 private
  def user_params
    params.permit(:email, :password)
  end

  def auth_params
    params.require(:authentication).permit(:url, :secret)
  end
end
