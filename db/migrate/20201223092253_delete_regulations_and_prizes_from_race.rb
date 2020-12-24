class DeleteRegulationsAndPrizesFromRace < ActiveRecord::Migration[6.0]
  def up
    remove_column :races, :regulation1
    remove_column :races, :regulation2
    remove_column :races, :regulation3
    remove_column :races, :regulation4
    remove_column :races, :prize1
    remove_column :races, :prize2
    remove_column :races, :prize3
    remove_column :races, :prize4
    remove_column :races, :prize5
  end

  def down
    add_column :races, :regulation1
    add_column :races, :regulation2
    add_column :races, :regulation3
    add_column :races, :regulation4
    add_column :races, :prize1
    add_column :races, :prize2
    add_column :races, :prize3
    add_column :races, :prize4
    add_column :races, :prize5
  end
end
