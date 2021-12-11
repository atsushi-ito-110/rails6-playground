class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  with_options presence: true do
    validates :name
    validates :email
  end
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      logger.info(data)
      user = User.create!(
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
