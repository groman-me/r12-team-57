class AddIFrameIdToDeck < ActiveRecord::Migration
  def change
    add_column :decks, :iframeid, :string
  end
end
