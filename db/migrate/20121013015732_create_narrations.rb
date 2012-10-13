class CreateNarrations < ActiveRecord::Migration
  def change
    create_table :narrations do |t|
      t.references :deck
      t.integer :state
      t.text :time_code

      t.timestamps
    end

    add_index :narrations, [:deck_id, :state]
  end
end
