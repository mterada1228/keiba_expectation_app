class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races, primary_key: :race_id do |t|
      t.string :race_date
      t.string :race_cource
      t.string :round
      t.string :race_name
      t.string :grade
      t.string :start_time
      t.string :cource_type
      t.string :distance
      t.string :turn
      t.string :side
      t.string :days
      t.string :regulation1
      t.string :regulation2
      t.string :regulation3
      t.string :regulation4
      t.string :prize1
      t.string :prize2
      t.string :prize3
      t.string :prize4
      t.string :prize5

      t.timestamps
    end
  end
end
