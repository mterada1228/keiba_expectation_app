class CreateRaceResults < ActiveRecord::Migration[6.0]
  def change
    create_table :race_results, :primary_key => :id do |t|
      t.string :name
      t.string :cource_id
      t.string :cource_length
      t.date :date
      t.string :cource_type
      t.string :cource_condition
      t.string :entire_rap
      t.float :ave_1F
      t.float :first_half_ave_3F
      t.float :last_half_ave_3
      t.float :RPCI
      t.string :prize
      t.string :hose_all_number

      t.timestamps
    end
  end
end
