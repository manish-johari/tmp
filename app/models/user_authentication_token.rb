class UserAuthenticationToken < ActiveRecord::Base
  belongs_to :user
end
