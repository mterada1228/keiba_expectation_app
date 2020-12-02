class ChangeDatatypeToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :race_date, :datetime
    change_column :races, :round, :integer
    change_column :races, :distance, :integer
    change_column :races, :days, :integer
    change_column :races, :prize1, :float
    change_column :races, :prize2, :float
    change_column :races, :prize3, :float
    change_column :races, :prize4, :float
    change_column :races, :prize5, :float
  end
end
