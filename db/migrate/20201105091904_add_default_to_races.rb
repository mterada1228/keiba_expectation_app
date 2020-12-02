class AddDefaultToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :course_type, :integer, default: 0
    change_column :races, :turn, :integer, default: 0
    change_column :races, :side, :integer, default: 0
  end
end
