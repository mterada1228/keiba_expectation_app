class ChangeIdToRaceResults < ActiveRecord::Migration[6.0]
  def change
    execute 'ALTER TABLE race_results CHANGE id id BIGINT NOT NULL;'
  end
end
