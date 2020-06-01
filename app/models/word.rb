class Word < ApplicationRecord
  belongs_to :user

  validates :word, presence: true
end
