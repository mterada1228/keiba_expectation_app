class DeleteStartTimeToRaces < ActiveRecord::Migration[6.0]
  def up
    remove_column :races, :start_time
  end

  def down
    add_column :races, :start_time, :time
  end
end
