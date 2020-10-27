class CreateHoseRaceResults < ActiveRecord::Migration[6.0]
  def change
    create_table :hose_race_results, id: false, primary_key: [:hose_id, :race_id] do |t|
      t.string :hose_id
      t.string :race_id
      t.string :gate_num         
      t.string :hose_num         
      t.string :odds             
      t.string :popularity       
      t.string :rank             
      t.string :jockey           
      t.string :burden_weight    
      t.string :time             
      t.string :time_diff        
      t.string :passing_order    
      t.string :last_3f          
      t.string :hose_weight      
      t.string :hose_weight_diff 
      t.string :get_prize        

      t.timestamps
    end
  end
end
