class Deck < ActiveRecord::Base
  attr_accessible :url

  belongs_to :user
  has_one :narration, dependent: :destroy

  validates :url, presence: true
end
