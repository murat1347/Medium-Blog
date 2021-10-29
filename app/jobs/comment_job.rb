class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    if comment.created_at.eql?(comment.updated_at)
      comment.update(accepted: true)
      puts "#{comment.id} comment accepted"
    end
  end
end
