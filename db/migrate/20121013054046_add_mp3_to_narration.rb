class AddMp3ToNarration < ActiveRecord::Migration
  def self.up
    add_attachment :narrations, :mp3
  end

  def self.down
    remove_attachment :narrations, :mp3
  end
end
