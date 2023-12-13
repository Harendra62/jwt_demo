class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]
    # before_action :find_user, only: [:show, :update, :destroy]
    def index
        @users =User.all
        render json: @users ,status: :ok
    end
    def show
       
        render json: @current_user ,status: :ok 
    end
    def create
        @user =User.new(user_params)
        if @user.save
            render json: @user ,status: :ok
        else
            render json:{errors: @user.errors.full_messages}, status: :ok
        end
    end
    def update
        # @user =User.find(params[:id])
        # if @user.update(user_params)
        #     render json: @user ,status: :ok
        # else
        unless @user.update(user_params)
            render json: {errors: @user.errors.full_messages}, status: :ok
        end
    end

    def destroy
        if @user.destroy
            render json: @user ,status: :ok
        else
            render json: {errors: @user.errors.full_messages}, status: :ok
        end
    end

    private
    def user_params
        params.require(:user).permit(:name,:user_name,:email,:password)
    end

    def find_user
        @user =User.find(params[:id])
    end
end
