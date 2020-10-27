class Race < ApplicationRecord
  has_many :race_horses
  has_many :horses, through: :race_horses

  enum cource_type: { no_definition_of_cource_type: 0, turf: 1, dirt: 2, hundle_race: 3 }
  enum turn: { no_definition_of_turn: 0, right: 1, left: 2, straight: 3 }
  enum side: { no_definition_of_side: 0, inner_cource: 1, external_cource: 2 }

  # TODO feature-add-rspec を merge したら以下の primary key の指定は不要
  self.primary_key = :id
end
