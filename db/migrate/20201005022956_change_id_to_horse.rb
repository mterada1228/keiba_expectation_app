class ChangeIdToHorse < ActiveRecord::Migration[6.0]
  def change
    execute 'ALTER TABLE horses CHANGE id id BIGINT NOT NULL;'
  end
end
