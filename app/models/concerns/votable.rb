module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(user)
    self.votes.create(user: user, rating: 1)
  end

  def vote_down(user)
    self.votes.create(user: user, rating: -1)
  end

  def vote_cancel(user)
    self.votes.where(user: user).delete_all
  end

  # сумма голосов
  def votes_summary
    votes.sum(:rating)
  end

  def voted?(user)
    votes.where(user: user).exists?
  end
end