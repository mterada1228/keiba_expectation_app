class Comment < ApplicationRecord
  belongs_to :horse
  belongs_to :race

  enum position: { positive: 0, negative: 1 }

  validates :description, presence: true, length: { maximum: 999 }
  validates :user_name, length: { maximum: 29 }
end
