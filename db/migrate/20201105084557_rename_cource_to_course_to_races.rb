class RenameCourceToCourseToRaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :races, :race_cource, :race_course
    rename_column :races, :cource_type, :course_type
  end
end
