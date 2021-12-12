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

  has_many_attached :images

  class << self
    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      unless user
        logger.info(data)
        user = User.create!(
          email: data['email'],
          name: email_to_name_by_before_at_mark(data['email']),
          password: Devise.friendly_token[0,20],
          confirmed_at: Time.now
        )
      end
      user
    end

    private
    def email_to_name_by_before_at_mark(email)
      /^[a-zA-Z0-9_.+-]+/.match(email).to_s
    end
  end
end
