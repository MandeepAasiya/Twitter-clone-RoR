class Like < ApplicationRecord
  validates :user, uniqueness: {scope: :tweet_id}
  belongs_to :user
  belongs_to :tweet
end
