class Deck < ActiveRecord::Base
  attr_accessible :author, :height, :html, :title, :url, :user_id, :width
  has_one :narration
end
