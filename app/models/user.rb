class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_one :profile
  has_one :user_authentication_token
  has_many :myinterests
  has_many :religions, through: :myinterests

  def self.from_omniauth(auth, current_user)
    provider = Provider.where(:provider => auth["provider"], :uid => auth["uid"].to_s).first_or_initialize
    if provider.user.blank?
      user = User.new
      user.password = Devise.friendly_token[0,10]
      user.skip_confirmation! # skip confirmation through email during signup via facebook.
      user.save(:validate => false)
      provider.user_id = user.id
    else
      provider.token = auth["token"]
    end
    provider.save
    provider.user
  end

end
