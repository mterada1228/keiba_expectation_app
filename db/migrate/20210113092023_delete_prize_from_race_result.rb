class DeletePrizeFromRaceResult < ActiveRecord::Migration[6.0]
  def up
    remove_column :race_results, :prize
  end

  def down
    remove_column :race_results, :prize, type: :float
  end
end
