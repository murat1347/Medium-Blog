class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  scope :accepteds, -> { where(accepted: true) }
  scope :accepteds_and_user_created, -> (user_id) { where(accepted: true).or(Comment.where(accepted: false, user_id: user_id))}
end
