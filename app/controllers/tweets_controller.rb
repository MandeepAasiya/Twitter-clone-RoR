class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show, :search, :hashtags, :likes ]
  

  def index
    if user_signed_in?
      @tweets = Tweet.where(parent_id: nil, user_id: current_user.following).order("created_at DESC").or(Tweet.where(user_id: current_user))
      following_ids = current_user.following.all
      @follower_suggestions = User.limit(3).where.not(id: following_ids).where.not(id: current_user.id)
    else
      @tweets = Tweet.where(parent_id: nil).order("created_at DESC")
      @follower_suggestions = User.limit(3)
    end

    @tweet = Tweet.new
  end


  def show
    if user_signed_in?
      @reply = current_user.tweets.build
    end
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save && @tweet.parent_id != nil
        format.html { redirect_to tweet_path(@tweet.parent_id), notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      elsif @tweet.save && @tweet.parent_id == nil
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @search_users = User.where("name LIKE ? or username LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
  end

  def hashtags
    tag = Tag.find_by(name: params[:name])
    @tweets = tag.tweets.order("created_at DESC")
  end

  def likes
    @tweet = Tweet.find(params[:id])
    @likes = @tweet.likes.all
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:tweet, :parent_id)
    end

end
