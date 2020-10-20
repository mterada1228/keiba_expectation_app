class Race < ApplicationRecord
  has_many :race_horses
  has_many :horses, through: :race_horses
  # TODO feature-add-rspec を merge したら以下の primary key の指定は不要
  self.primary_key = :id
end
