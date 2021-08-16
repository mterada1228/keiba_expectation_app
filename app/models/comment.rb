class Comment < ApplicationRecord
  belongs_to :horse_race, foreign_key: [:horse_id, :race_id]

  enum comment_type: { positive: 0, negative: 1 }

  validates :description, presence: true, length: { maximum: 999 }
  validates :user_name, length: { maximum: 29 }

  before_save :convert_user_name_from_blank_to_nil

  private

  def convert_user_name_from_blank_to_nil
    self.user_name = nil if user_name.blank?
  end
end
