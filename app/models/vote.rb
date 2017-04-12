class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true

  validates :rating, presence: true
end