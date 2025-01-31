class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/,
                                 message: I18n.t('models.user.password_validation'),
                                 allow_nil: true }

  validates :email, presence: true, uniqueness: { case_sensitive: true }

  self.inheritance_column = :type # Enables Single Table Inheritance (STI)
end
