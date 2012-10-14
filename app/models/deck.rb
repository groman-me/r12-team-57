class Deck < ActiveRecord::Base
  attr_accessible :url

  STATES = { empty: -1 }.merge!(Narration::STATES)
  belongs_to :user
  has_one :narration, dependent: :destroy

  validates :url, presence: true
  validate :url_is_a_speakerdeck_presentation

  def state
    if narration.blank?
      STATES[:empty]
    else
      narration.state
    end
  end

  def self.create_from_oembed_deck(attributes)
    create(attributes) do |deck|
      deck.title = deck.oembed['title']
      deck.author = deck.oembed['author_name']
      deck.html = deck.oembed['html']
      deck.width = deck.oembed['width']
      deck.height = deck.oembed['height']
      deck.iframeid = URI.parse(deck.oembed['html'].match(/\/\/[\w.\/]*/)[0]).path.gsub('/embed/','')
    end
  end

  def oembed
    @oembed ||= begin
      client = SpeakerDeck.new
      client.fetch(self.url, maxwidth: 780) || {}
    end
  end
  
  def narrated?
    self.narration.present? && self.narration.complete?
  end
  
  def in_progress?
    self.narration.present? && self.narration.in_progress?
  end
  
  private

  def url_is_a_speakerdeck_presentation
    errors.add(:url, "can't find slides") if oembed.blank?
  end
end
