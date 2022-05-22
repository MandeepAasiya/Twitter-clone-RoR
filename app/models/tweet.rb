class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy

    has_and_belongs_to_many :tags

    has_one_attached :image

    validates :tweet, length: 1..140

    after_create do
        current_tweet = Tweet.find_by(id: self.id)
        hashtags = self.tweet.scan(/#\w+/)
        hashtags.uniq.map do | hashtag |
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            current_tweet.tags << tag
        end
    end

    before_update do
        current_tweet = Tweet.find_by(id: self.id)
        current_tweet.tags.clear
        hashtags = self.tweet.scan(/#\w+/)
        hashtags.uniq.map do | hashtag |
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            current_tweet.tags << tag
        end
    end

end

