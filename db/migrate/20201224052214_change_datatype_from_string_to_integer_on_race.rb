class ChangeDatatypeFromStringToIntegerOnRace < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :course, :integer
    change_column :races, :grade, :integer
  end
end
