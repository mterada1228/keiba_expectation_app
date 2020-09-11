class CreateRaceHoses < ActiveRecord::Migration[6.0]
  def change
    create_table :race_hoses, id: false, primary_key: [:race_id, :hose_id]  do |t|
      t.string :race_id
      t.string :hose_id
      t.string :gate_num
      t.string :hose_num

      t.timestamps
    end
  end
end
