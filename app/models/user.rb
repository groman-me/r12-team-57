class User < ActiveRecord::Base
  has_many :decks, dependent: :destroy

  validates :uid, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    find_and_update_from_auth(auth) || create_from_auth(auth)
  end

  def self.create_from_auth(auth)
    create! { |user| user.set_attributes_from_auth(auth) }
  end

  def self.find_and_update_from_auth(auth)
    user = where(uid: auth['uid'].to_s).first
    user.set_attributes_from_auth(auth) and user.save if user
    user
  end

  def set_attributes_from_auth(auth)
    self.uid = auth['uid']
    self.name = auth['info']['name']
    self.nickname = auth['info']['nickname']
    self.profile_image_url = URI.parse(auth['info']['image']).to_s
  end
end
