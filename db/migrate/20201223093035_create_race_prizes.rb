class CreateRacePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :race_prizes do |t|
      t.references :race, foreign_key: true
      t.integer :order_of_arrival
      t.integer :prize

      t.timestamps
    end
  end
end
