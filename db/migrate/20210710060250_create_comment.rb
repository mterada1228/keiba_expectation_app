class CreateComment < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.bigint :horse_id, null: false
      t.string :race_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :user_name
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_foreign_key :comments, :horses
    add_foreign_key :comments, :races
  end
end
