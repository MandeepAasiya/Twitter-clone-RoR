require 'rails_helper'

current_user = User.first_or_create!(email: '123@abc.com',name: '123@abc.com',username: '123@abc.com',password: 'mandeep', password_confirmation: 'mandeep')

RSpec.describe Tweet, type: :model do
  it 'has a tweet' do
    tweet = Tweet.new(
      tweet: "",
      user: current_user
    )
    expect(tweet).to_not be_valid
    tweet.tweet = "hellooooooo"
    expect(tweet).to be_valid
  end
  
end
