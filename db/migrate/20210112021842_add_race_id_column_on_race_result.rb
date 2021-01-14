class AddRaceIdColumnOnRaceResult < ActiveRecord::Migration[6.0]
  def change
    add_reference :race_results, :race, foreign_key: true, after: :id
  end
end
