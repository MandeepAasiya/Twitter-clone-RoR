class FriendshipsController < ApplicationController

    before_action :authenticate_user!, except: [ :profile, :followers_list, :followings_list ]
    before_action :find_user

    def profile
        @user = User.find(params[:user_id])
        if @user.is_active == false && @user.id != current_user.id
            user = User.find(params[user_id: -1])
        end
        @tweets = @user.tweets
        if user_signed_in?
            @conversation = Conversation.where(recipient_id: current_user.id, sender_id: @user.id).or(Conversation.where(sender_id: current_user.id, recipient_id: @user.id))
        end
    end

    def followers_list
        @user = User.find(params[:user_id])
        @followers_list = @user.followers.where(is_active: true)
        if user_signed_in?
            @conversation = Conversation.where(recipient_id: current_user.id, sender_id: @user.id).or(Conversation.where(sender_id: current_user.id, recipient_id: @user.id))
        end
    end

    def followings_list
        @user = User.find(params[:user_id])
        @followings_list = @user.following.where(is_active: true)
        if user_signed_in?
            @conversation = Conversation.where(recipient_id: current_user.id, sender_id: @user.id).or(Conversation.where(sender_id: current_user.id, recipient_id: @user.id))
        end
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
    end

end