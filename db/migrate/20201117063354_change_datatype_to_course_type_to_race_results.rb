class ChangeDatatypeToCourseTypeToRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :race_results, :course_type, :integer
  end
end
