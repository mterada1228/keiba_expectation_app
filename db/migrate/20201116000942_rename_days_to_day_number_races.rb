class RenameDaysToDayNumberRaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :races, :days, :day_number
  end
end
