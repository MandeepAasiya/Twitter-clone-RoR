class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :email, :username
  validates :email, length: 5..25
  validates :username, length: 4..25
  validates :name, length: 3..30
  validates :bio, length: {maximum: 50}, allow_blank: true


  has_one_attached :avatar

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :active_friendships, class_name:"Friendship", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_friendships, class_name:"Friendship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_friendships, source: :followed

  has_many :followers, through: :passive_friendships, source: :follower

  def follow(user)
    active_friendships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_friendships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_fill: [150, nil]).processed
    else
      '/default_profile.jpg'
    end
  end
    
end
