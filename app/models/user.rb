class User < ActiveRecord::Base

  validates :uid, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(auth.slice('uid')).first || create_from_auth(auth)
  end

  def self.create_from_auth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.nickname = auth['info']['nickname']
      user.profile_image_url = URI.parse(auth['info']['image']).to_s
    end
  end
end
