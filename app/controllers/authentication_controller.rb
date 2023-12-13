class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user
    extend JwtToken

    def login
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
            token = AuthenticationController.jwt_encode(@user.id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                                     username: @user.user_name }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
end
