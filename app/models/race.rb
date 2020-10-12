class Race < ApplicationRecord
  has_many :race_horses

  # TODO feature-add-rspec を merge したら以下の primary key の指定は不要
  self.primary_key = :id
end
