class FriendshipsController < ApplicationController

    before_action :authenticate_user!, except: [ :profile, :followers_list, :followings_list ]
    before_action :find_user

    def profile
        @user = User.find(params[:user_id])
        #@finduser = User.find_by(params[:username])
        @tweets = @user.tweets
    end

    def followers_list
        @user = User.find(params[:user_id])
        @followers_list = @user.followers.all
    end

    def followings_list
        @user = User.find(params[:user_id])
        @followings_list = @user.following.all
    end

    def create
        current_user.follow(@user)
        redirect_to profile_path(user_id: @user.id)
    end

    def destroy
        current_user.unfollow(@user)
        redirect_to profile_path(user_id: @user.id)
    end

    private

    def find_user
        @user = User.find(params[:user_id])
        #@finduser = User.find_by(params[:username])
    end

end