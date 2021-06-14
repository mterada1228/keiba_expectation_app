class IntegrateRaceResultAndRace < ActiveRecord::Migration[6.0]
  def up
    add_column :races, :has_result, :boolean, null: false
    add_column :races, :course_condition, :integer
    add_column :races, :entire_rap, :string
    add_column :races, :ave_1F, :float
    add_column :races, :first_half_ave_3F, :float
    add_column :races, :last_half_ave_3F, :float
    add_column :races, :RPCI, :float
    add_column :races, :horse_all_number, :integer
    drop_table :race_results
  end

  def down # rubocop:disable Metrics/MethodLength
    remove_column :races, :has_result
    remove_column :races, :cource_condition
    remove_column :races, :entire_rap
    remove_column :races, :ave_1F
    remove_column :races, :first_half_ave_3F
    remove_column :races, :last_half_ave_3F
    remove_column :races, :RPCI
    remove_column :races, :horse_all_number
    create_table :race_results do |t|
      t.references :race, foreign_key: true
      t.integer :course_condition, null: false
      t.string :entire_rap
      t.float :ave_1F
      t.float :first_half_ave_3F
      t.float :last_half_ave_3F
      t.float :RPCI
      t.integer :horse_all_number
    end
    execute 'ALTER TABLE race_results ADD PRIMARY KEY race_id);'
  end
end
