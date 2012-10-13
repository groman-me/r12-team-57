class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :url
      t.string :title
      t.string :author
      t.integer :width
      t.integer :height
      t.references :user
      t.text :html

      t.timestamps
    end

    add_index :decks, :url
    add_index :decks, :user_id
  end
end
