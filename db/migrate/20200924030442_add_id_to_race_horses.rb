#
# add id column to race_horse table
#
class AddIdToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    add_column :race_horses, :id, :primary_key, unsigned: true, first: true
  end
end
