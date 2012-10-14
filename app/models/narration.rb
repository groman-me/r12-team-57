class Narration < ActiveRecord::Base
  attr_accessible :deck_id, :time_code, :wav, :state

  STATES = { not_ready: 1, in_progress: 2, complete: 3 }

  belongs_to :deck
  validates :deck, :presence => true
  validates_inclusion_of :state, in: STATES.values
  validate :check_state

  has_attached_file :wav, storage: :filesystem, path: ':rails_root/files:url'
  has_attached_file :mp3, storage: :filesystem

  def async_encode
    workers_count = begin
      Resque.info[:workers]
    rescue
      0
    end

    if workers_count > 0
      Resque.enqueue NarrationEncoder, self.id
    else
      NarrationEncoder.perform self.id
    end
  end

  protected

  def check_state
    case state
    when STATES[:not_ready]
      errors.add(:state, "can't be \"not ready\" if mp3 presents") if mp3.present?
    when STATES[:in_progress]
      errors.add(:state, "can't be \"in progress\" if mp3 presents") if mp3.present?
      errors.add(:state, "can't be \"in progress\" before save") unless persisted?
    when STATES[:complete]
      errors.add(:state, "can't be \"complete\" unless mp3 present") unless mp3.present?
    end
  end

end
