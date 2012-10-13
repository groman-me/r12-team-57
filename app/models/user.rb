class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :uid
end
