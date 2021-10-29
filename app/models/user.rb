# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { maximum: 50, minimum: 5 }
  validates :email, presence: true
  has_many :articles

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy, inverse_of: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy, inverse_of: :followed

  has_many :following, through: 'active_relationships', source: 'followed'
  has_many :followers, through: 'passive_relationships', source: 'follower'


  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Article.where('user_id IN (?)', following_ids).visible
  end
end