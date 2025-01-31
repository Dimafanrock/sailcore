class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{24}\z/
  NAME_LENGTH = { minimum: 4, maximum: 256 }.freeze

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: NAME_LENGTH
  validates :nickname, allow_nil: true, length: NAME_LENGTH
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, format: { with: PASSWORD_FORMAT, message: I18n.t('models.user.password_validation') }, allow_nil: true

  self.inheritance_column = :type # Enables STI

  def role
    type.downcase if type.present?
  end

  def self.generate_secure_password
    SecureRandom.base58(24)
  end

  def generate_jwt
    JsonWebToken.encode(user_id: id, type: type)
  end

  def send_password_email(_password)
    "UserMailer.send_generated_password(self, password).deliver_now"
  end
end
