class AddNotNullContraintToHorses < ActiveRecord::Migration[6.0]
  def change
    change_column_null :horses, :name, false, 0
  end
end
