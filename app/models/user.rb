class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  PASSWORD_FORMAT     = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{24}\z/
  REQUIRED_CHARACTERS = {
    uppercase: ('A'..'Z').to_a,
    lowercase: ('a'..'z').to_a,
    digit: ('0'..'9').to_a
  }.freeze
  NAME_LENGTH         = { minimum: 4, maximum: 256 }.freeze
  PASSWORD_LENGTH     = 24

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, allow_nil: true, length: NAME_LENGTH
  validates :nickname, allow_nil: true, length: NAME_LENGTH
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, format: { with: PASSWORD_FORMAT, message: I18n.t('models.user.password_validation') }, allow_nil: true

  self.inheritance_column = :type # Enables STI

  def role
    type.downcase if type.present?
  end

  def self.generate_secure_password
    required_chars = [
      REQUIRED_CHARACTERS[:uppercase].sample,
      REQUIRED_CHARACTERS[:lowercase].sample,
      REQUIRED_CHARACTERS[:digit].sample
    ]

    remaining_chars = SecureRandom.base58(PASSWORD_LENGTH - required_chars.size).chars
    (required_chars + remaining_chars).shuffle.join
  end

  def send_password_email(_password)
    "UserMailer.send_generated_password(self, password).deliver_now"
  end
end
