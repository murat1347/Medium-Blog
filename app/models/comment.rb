class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  scope :accepteds, -> { where(accepted: true) }

  #  scope :accepteds_by_user, ->(user_id) { where('accepted = false and article.user_id = ?', user_id).joins(:article).where(articles: {id: 1}) }
end
