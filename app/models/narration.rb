class Narration < ActiveRecord::Base
  attr_accessible :deck_id, :time_code, :wav

  belongs_to :deck
  #validates :deck, :presence => true

  has_attached_file :wav, storage: :filesystem
  has_attached_file :mp3, storage: :filesystem

end
