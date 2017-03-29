class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order('best DESC') }

  def set_best
    Answer.transaction do
      old_answer = self.question.answers.find_by(best: true)
      old_answer.update!(best: false) if old_answer
      self.update!(best: true)
    end
  end
end
