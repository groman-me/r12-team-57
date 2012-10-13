class AddWavToNarration < ActiveRecord::Migration
  def self.up
    add_attachment :narrations, :wav
  end

  def self.down
    remove_attachment :narrations, :wav
  end
end
