class CreateRaceRegulations < ActiveRecord::Migration[6.0]
  def change
    create_table :race_regulations do |t|
      t.references :race, foreign_key: true
      t.integer :regulation
      
      t.timestamps
    end
  end
end
