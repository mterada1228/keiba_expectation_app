class CreateHoses < ActiveRecord::Migration[6.0]
  def change
    create_table :hoses, primary_key: :hose_id do |t|
      t.string :name

      t.timestamps
    end
  end
end
