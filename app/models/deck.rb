class Deck < ActiveRecord::Base
  attr_accessible :url

  STATES = { empty: -1 }.merge!(Narration::STATES)
  belongs_to :user
  has_one :narration, dependent: :destroy

  validates :url, presence: true

  def state
    if narration.blank?
      STATES[:empty]
    else
      narration.state
    end
  end
end
