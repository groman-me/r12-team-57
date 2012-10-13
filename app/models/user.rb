class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice('uid')).first || create_from_auth(auth)
  end

  def self.create_from_auth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.nickname = auth['info']['nickname']
    end
  end
end
