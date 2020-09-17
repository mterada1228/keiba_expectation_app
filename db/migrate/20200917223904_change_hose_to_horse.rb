class ChangeHoseToHorse < ActiveRecord::Migration[6.0]
  def change
    rename_table :hoses, :horses
  end
end