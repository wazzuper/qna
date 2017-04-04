class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  scope :ordered, -> { order('best DESC') }

  def set_best
    Answer.transaction do
      old_answer = self.question.answers.find_by(best: true)
      old_answer.update!(best: false) if old_answer
      self.update!(best: true)
    end
  end
end
