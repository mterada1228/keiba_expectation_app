class ChangeIdToRaces < ActiveRecord::Migration[6.0]
  def change
    execute 'ALTER TABLE races CHANGE id id BIGINT NOT NULL;'
  end
end
