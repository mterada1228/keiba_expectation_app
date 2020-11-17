class RenameColumnsToRaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :races, :race_date, :start
    rename_column :races, :race_course, :course
    rename_column :races, :race_name, :name
  end
end
