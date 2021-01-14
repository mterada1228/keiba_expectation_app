class DeleteDuplicateColumnOnRaceResult < ActiveRecord::Migration[6.0]
  def up
    remove_column :race_results, :name
    remove_column :race_results, :course_id
    remove_column :race_results, :course_length
    remove_column :race_results, :date
    remove_column :race_results, :course_type
  end

  def down
    add_column :race_results, :name
    add_column :race_results, :course_id
    add_column :race_results, :course_length
    add_column :race_results, :date
    add_column :race_results, :course_type
  end
end
