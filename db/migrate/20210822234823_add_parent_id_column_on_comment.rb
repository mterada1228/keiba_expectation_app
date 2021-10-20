class AddParentIdColumnOnComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :parent, foreign_key: { to_table: :comments }, after: :race_id
  end
end
