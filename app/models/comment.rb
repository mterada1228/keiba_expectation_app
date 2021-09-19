class Comment < ApplicationRecord
  belongs_to :horse_race, foreign_key: [:horse_id, :race_id]
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :replies, class_name: Comment.name, foreign_key: :parent_id, dependent: :destroy

  enum comment_type: { positive: 0, negative: 1 }

  validates :description, presence: true, length: { maximum: 999 }
  validates :user_name, length: { maximum: 29 }
  validate  :validate_parent_id

  before_save :convert_user_name_from_blank_to_nil

  private

  def convert_user_name_from_blank_to_nil
    self.user_name = nil if user_name.blank?
  end

  def validate_parent_id
    return if parent_id.nil? || Comment.exists?(parent_id)

    errors.add(:base, '返信元コメントが存在しません')
  end
end
