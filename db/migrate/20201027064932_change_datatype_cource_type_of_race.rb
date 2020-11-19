class ChangeDatatypeCourceTypeOfRace < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :cource_type, :integer
  end
end
